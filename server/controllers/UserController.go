package controllers

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/services"

	"github.com/go-playground/validator/v10"
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

func (uc *UserController) Me(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)
	userDTO, err := uc.userService.GetUser(currentUser.ID)
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": err.Error()})
	}
	return c.JSON(userDTO)
}

func (uc *UserController) GetUser(c *fiber.Ctx) error {
	c.Set("Content-Type", "application/json; charset=utf-8")

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

func (uc *UserController) Verify(c *fiber.Ctx) error {
	var requestBody dtos.VerifyCodeDTO
	if err := c.BodyParser(&requestBody); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	ctx := context.WithValue(c.Context(), "user_id", "verify")
	user, err := uc.userService.Verify(ctx, requestBody)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "An error occurred"})
	}
	return c.Status(fiber.StatusOK).JSON(fiber.Map{"message": "Id verified successfully", "user": user})
}

func (uc *UserController) ValidateUser(c *fiber.Ctx) error {
	var requestBody dtos.ValidateUserDTO
	if err := c.BodyParser(&requestBody); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	ctx := context.WithValue(c.Context(), "user_id", "validateUser")
	hasBeenUserUpdated, err := uc.userService.ValidateUser(ctx, requestBody)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "An error occurred"})
	}
	if !hasBeenUserUpdated {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid code"})
	} else {
		return c.Status(fiber.StatusOK).JSON(fiber.Map{"message": "User activated successfully"})
	}
}

func (uc *UserController) UpdateUser(c *fiber.Ctx) error {
	var updateUserDTO dtos.UpdateUserDTO
	if err := c.BodyParser(&updateUserDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	validations := validator.New()
	err := validations.Struct(updateUserDTO)
	if err != nil {
		errors := make([]string, 0)
		for _, err := range err.(validator.ValidationErrors) {
			errors = append(errors, err.Error())
		}
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{"error": errors})
	}

	userID := c.Params("id")
	ctx := context.WithValue(c.Context(), "user_id", userID)
	updatedUser, err := uc.userService.UpdateUser(ctx, userID, updateUserDTO)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}

	return c.JSON(updatedUser)
}

func (uc *UserController) GetUserSubjects(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)
	subjects, err := uc.userService.GetUserSubjects(currentUser.ID)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}
	return c.JSON(subjects)
}
