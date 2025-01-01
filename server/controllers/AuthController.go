package controllers

import (
	"bytes"
	"context"
	"edumeet/dtos"
	"edumeet/services"
	"edumeet/utils"
	customValidator "edumeet/validator"
	"fmt"
	"html/template"
	"log"
	"os"

	"github.com/go-playground/validator/v10"
	"github.com/gofiber/fiber/v2"
)

type AuthController struct {
	authService  *services.AuthService
	emailService *services.EmailService
}

func NewAuthController(authService *services.AuthService, emailService *services.EmailService) *AuthController {
	return &AuthController{
		authService:  authService,
		emailService: emailService,
	}
}

func (ac *AuthController) Login(c *fiber.Ctx) error {
	var requestBody dtos.LoginDTO
	if err := c.BodyParser(&requestBody); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}
	token, user, err := ac.authService.Login(requestBody)
	if err != nil {
		switch err {
		case utils.ErrInvalidCredentials:
			return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "Invalid username or password"})
		case utils.ErrAccountNotActivated:
			return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Account not activated"})
		default:
			return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "An error occurred"})
		}
	}
	return c.Status(fiber.StatusOK).JSON(fiber.Map{"token": token, "user": user})
}

func (uc *AuthController) Register(c *fiber.Ctx) error {
	var registerDTO dtos.RegisterDTO
	if err := c.BodyParser(&registerDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	validations := validator.New()
	validations.RegisterValidation("IsUsernameValid", customValidator.IsUsernameValid)
	validations.RegisterValidation("IsPasswordValid", customValidator.IsPasswordValid)

	errors, err := customValidator.ValidateDTO(validations, &registerDTO)

	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"error": "Erreur de validation interne",
		})
	}
	if len(errors) > 0 {
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{
			"errors": errors,
		})
	}

	ctx := context.WithValue(c.Context(), "user_id", "register")
	user, err := uc.authService.RegisterUser(ctx, registerDTO)
	if err != nil {
		log.Printf("Error creating user: %v", err)
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}

	tmpl, err := template.ParseFiles("./email/register.html")
	if err != nil {
		log.Fatalf("Error loading email template: %v", err)
		return err
	}

	ulid := utils.ULID{}
	verificationCode := ulid.GenerateUlid()()
	utils.StoreValidationCodeInRedis(user.ID, verificationCode, 30)
	var body bytes.Buffer
	var data = map[string]interface{}{
		"VERIFICATION_CODE": verificationCode,
		"USER_FIRSTNAME":    user.Firstname,
	}
	if err := tmpl.Execute(&body, data); err != nil {
		log.Fatalf("Error executing template: %v", err)
		return err
	}
	err = uc.emailService.SendEmail(user.Email, "Welcome!", body.String())
	if err != nil {
		log.Printf("Error sending email: %v", err)
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "Could not send confirmation email"})
	}
	
	return c.Status(fiber.StatusCreated).JSON(user)
}

func (ac *AuthController) ForgotPassword(c *fiber.Ctx) error {
	var requestBody dtos.ForgotPasswordDTO
	if err := c.BodyParser(&requestBody); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}
	currentUser, code, err := ac.authService.ForgotPassword(requestBody)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error(), "message": "An error occurred"})
	}
	tmpl, err := template.ParseFiles("./email/forgotPwd.html")
	if err != nil {
		log.Fatalf("Error loading email template: %v", err)
		return err
	}
	var body bytes.Buffer
	var data = map[string]interface{}{
		"VERIFICATION_CODE": code,
		"USER_FIRSTNAME":    currentUser.Firstname,
	}
	if err := tmpl.Execute(&body, data); err != nil {
		log.Fatalf("Error executing template: %v", err)
		return err
	}
	err = ac.emailService.SendEmail(currentUser.Email, "Reset your password", body.String())
	if err != nil {
		log.Printf("Error sending email: %v", err)
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "Could not send confirmation email"})
	}
	return c.Status(fiber.StatusOK).JSON(fiber.Map{"message": "Id sent successfully"})
}

func (ac *AuthController) ResetPassword(c *fiber.Ctx) error {
	var requestBody dtos.ResetPasswordDTO
	if err := c.BodyParser(&requestBody); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}
	validations := validator.New()
	validations.RegisterValidation("strongPassword", customValidator.StrongPassword)
	err := validations.Struct(requestBody)
	if err != nil {
		errors := make([]string, 0)
		for _, err := range err.(validator.ValidationErrors) {
			errors = append(errors, err.Error())
		}
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{"error": errors})
	}
	err = ac.authService.ResetPassword(requestBody)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "An error occurred"})
	}
	return c.Status(fiber.StatusOK).JSON(fiber.Map{"message": "Password reset successfully"})
}

func (uc *UserController) ResendEmailValidateUser(c *fiber.Ctx) error {
	email := c.Params("email")
	user, err := uc.userService.GetUserByEmail(email)
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": err.Error()})
	}
	if user.Activated {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "User already activated"})
	}
	tmpl, err := template.ParseFiles("./email/register.html")
	if err != nil {
		log.Fatalf("Error loading email template: %v", err)
		return err
	}
	ulid := utils.ULID{}
	verificationCode := ulid.GenerateUlid()()
	var body bytes.Buffer
	var data = map[string]interface{}{
		"URL": fmt.Sprintf("%s/user/verify-email/%s", os.Getenv("FRONTEND_URL"), verificationCode),
	}
	if err := tmpl.Execute(&body, data); err != nil {
		log.Fatalf("Error executing template: %v", err)
		return err
	}
	err = uc.emailService.SendEmail(user.Email, "Welcome!", body.String())
	if err != nil {
		log.Printf("Error sending email: %v", err)
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "Could not send confirmation email"})
	}
	utils.StoreValidationCodeInRedis(user.ID, verificationCode)
	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"message": "User activated successfully",
		"user":    user,
	})
}
