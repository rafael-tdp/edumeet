package controllers

import (
	"bytes"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/services"
	"edumeet/utils"
	"fmt"
	"html/template"
	"log"
	"os"

	"github.com/gofiber/fiber/v2"
	"github.com/oklog/ulid/v2"
)

type UserController struct {
	userService  *services.UserService
	emailService *services.EmailService
}

func NewUserController(userService *services.UserService, emailService *services.EmailService) *UserController {
	return &UserController{
		userService:  userService,
		emailService: emailService,
	}
}

func (uc *UserController) GetUser(c *fiber.Ctx) error {

	currentUser := c.Locals("user").(*ent.User)

	userID, err := ulid.Parse(c.Params("id"))

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	if currentUser.ID == userID.String() || currentUser.Role == "ADMIN" {

		user, err := uc.userService.GetUser(userID.String())
		if err != nil {
			return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": err.Error()})
		}

		return c.JSON(user)
	} else {
		user, err := uc.userService.GetUserProfile(userID.String())

		if err != nil {
			return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": err.Error()})
		}
		return c.JSON(user)
	}
}

func (uc *UserController) Register(c *fiber.Ctx) error {
	var registerDTO dtos.RegisterDTO

	if err := c.BodyParser(&registerDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	validations := validator.New()
	err := validations.Struct(registerDTO)
	if err != nil {
		errors := make([]string, 0)
		for _, err := range err.(validator.ValidationErrors) {
			errors = append(errors, err.Error())
		}
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{"error": errors})
	}

	user, err := uc.userService.RegisterUser(registerDTO)
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

func (uc *UserController) ValidateUser(c *fiber.Ctx) error {
	var requestBody dtos.ValidateUserDTO

	if err := c.BodyParser(&requestBody); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	hasBeenUserUpdated, err := uc.userService.ValidateUser(requestBody)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "An error occurred"})
	}

	if !hasBeenUserUpdated {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid code"})
	} else {
		return c.Status(fiber.StatusOK).JSON(fiber.Map{"message": "User activated successfully"})
	}
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

func (uc *UserController) Login(c *fiber.Ctx) error {
	var requestBody dtos.LoginDTO

	if err := c.BodyParser(&requestBody); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	token, err := uc.userService.Login(requestBody)
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

	return c.Status(fiber.StatusOK).JSON(fiber.Map{"token": token})
}

func (uc *UserController) Me(c *fiber.Ctx) error {

	currentUser := c.Locals("user").(*ent.User)

	userDTO, err := uc.userService.GetUser(currentUser.ID)
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": err.Error()})
	}

	return c.JSON(userDTO)
}

func (uc *UserController) ForgotPassword(c *fiber.Ctx) error {
	var requestBody dtos.ForgotPasswordDTO

	if err := c.BodyParser(&requestBody); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	currentUser, code, err := uc.userService.ForgotPassword(requestBody)
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

	err = uc.emailService.SendEmail(currentUser.Email, "Reset your password", body.String())

	if err != nil {
		log.Printf("Error sending email: %v", err)
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "Could not send confirmation email"})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{"message": "Id sent successfully"})
}

func (uc *UserController) Verify(c *fiber.Ctx) error {
	var requestBody dtos.VerifyCodeDTO

	if err := c.BodyParser(&requestBody); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	user, err := uc.userService.Verify(requestBody)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "An error occurred"})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{"message": "Id verified successfully", "user": user})
}

func (uc *UserController) ResetPassword(c *fiber.Ctx) error {
	var requestBody dtos.ResetPasswordDTO

	if err := c.BodyParser(&requestBody); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	err := uc.userService.ResetPassword(requestBody)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "An error occurred"})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{"message": "Password reset successfully"})
}
