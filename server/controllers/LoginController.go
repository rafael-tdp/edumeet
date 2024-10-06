// File: controllers/login_controller.go
package controllers

import (
	"context"
	"edumeet/services"
	"edumeet/structures"
	"edumeet/utils"

	"github.com/gofiber/fiber/v2"
)

type LoginController struct {
	userService *services.UserService
}

func NewLoginController(userService *services.UserService) *LoginController {
	return &LoginController{
		userService: userService,
	}
}

func (lc *LoginController) LoginHandler(c *fiber.Ctx) error {
	var requestBody structures.Login

	if err := c.BodyParser(&requestBody); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	token, err := lc.userService.Login(context.Background(), requestBody)
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
