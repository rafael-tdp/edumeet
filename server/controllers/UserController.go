package controllers

import (
	"bytes"
	"edumeet/dtos"
	"edumeet/services"
	"edumeet/utils"
	"html/template"
	"log"

	"github.com/gofiber/fiber/v2"
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

	userID := c.Params("id")

	user, err := uc.userService.GetUser(userID)
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": err.Error()})
	}

	return c.JSON(user)
}

func (uc *UserController) Register(c *fiber.Ctx) error {
	var registerDTO dtos.RegisterDTO

	if err := c.BodyParser(&registerDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	user, err := uc.userService.RegisterUser(registerDTO)
	if err != nil {
		log.Printf("Error creating user: %v", err)
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "Could not create user"})
	}

	tmpl, err := template.ParseFiles("./email/register.html")
	if err != nil {
		log.Fatalf("Error loading email template: %v", err)
		return err
	}

	var body bytes.Buffer
	if err := tmpl.Execute(&body, user); err != nil {
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

	code := c.Params("code")

	user, err := uc.userService.ValidateUser(code)
	if err != nil {

		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"message": "User activated successfully",
		"user":    user,
	})
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

	var body bytes.Buffer
	if err := tmpl.Execute(&body, user); err != nil {
		log.Fatalf("Error executing template: %v", err)
		return err
	}

	err = uc.emailService.SendEmail(user.Email, "Welcome!", body.String())

	if err != nil {
		log.Printf("Error sending email: %v", err)
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "Could not send confirmation email"})
	}

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

	userID := c.Locals("user_id").(string)

	userDTO, err := uc.userService.GetUser(userID)
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": err.Error()})
	}

	return c.JSON(userDTO)
}
