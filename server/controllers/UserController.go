package controllers

import (
	"bytes"
	"context"
	"edumeet/dtos"
	"edumeet/services"
	"html/template"
	"log"

	"github.com/gofiber/fiber/v2"
)

type UserController struct {
	userService  *services.UserService
	emailService *services.EmailServiceSMTP
}

func NewUserController(userService *services.UserService, emailService *services.EmailServiceSMTP) *UserController {
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

	user, err := uc.userService.ValidateUser(context.Background(), code)
	if err != nil {

		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"message": "User activated successfully",
		"user":    user,
	})
}
