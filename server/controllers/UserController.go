package controllers

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/guards"
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

func (uc *UserController) UpdateUserSubjects(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)
	var subjects []string
	if err := c.BodyParser(&subjects); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	ctx := context.WithValue(c.Context(), "user_id", currentUser.ID)
	err := uc.userService.UpdateUserSubjects(ctx, currentUser.ID, subjects)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}
	return c.JSON(fiber.Map{"message": "Subjects updated successfully"})
}

func (uc *UserController) CreateFriendship(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)
	var friendshipDTO dtos.FriendshipDTO
	if err := c.BodyParser(&friendshipDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	ctx := context.WithValue(c.Context(), "user_id", currentUser.ID)
	friendship, err := uc.userService.CreateFriendship(ctx, currentUser.ID, friendshipDTO)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}
	return c.JSON(friendship)
}

func (uc *UserController) UpdateFriendship(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)
	friendshipID := c.Params("id")
	var friendshipDTO dtos.FriendshipDTO
	if err := c.BodyParser(&friendshipDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	ctx := context.WithValue(c.Context(), "user_id", currentUser.ID)
	friendship, err := uc.userService.UpdateFriendship(ctx, friendshipID, friendshipDTO.Status)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}
	return c.JSON(friendship)
}

func (uc *UserController) GetFriendships(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)
	friendships, err := uc.userService.GetFriendships(currentUser.ID)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}
	return c.JSON(friendships)
}

func (uc *UserController) DeleteFriendship(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)
	friendshipID := c.Params("id")
	ctx := context.WithValue(c.Context(), "user_id", currentUser.ID)
	err := uc.userService.DeleteFriendship(ctx, friendshipID)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}
	return c.JSON(fiber.Map{"message": "Friendship deleted successfully"})
}

func (uc *UserController) GetUsers(c *fiber.Ctx) error {
	users, err := uc.userService.GetUsers()
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}
	return c.JSON(users)
}

func (uc *UserController) UpdateUserAdmin(c *fiber.Ctx) error {
	var updateUserDTO dtos.UpdateUserAdminDTO
	userID := c.Params("id")
	currentUser := c.Locals("user").(*ent.User)
	ctx := context.WithValue(c.Context(), "user_id", currentUser.ID)
	updateUserDTO.Id = userID

	if !guards.IsAdmin(currentUser) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}

	if err := c.BodyParser(&updateUserDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
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

	updatedUser, err := uc.userService.UpdateUserAdmin(ctx, updateUserDTO)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}

	return c.JSON(updatedUser)
}

func (uc *UserController) CreateUserAdmin(c *fiber.Ctx) error {

	currentUser := c.Locals("user").(*ent.User)

	if !guards.IsAdmin(currentUser) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}

	var createUserDTO dtos.CreateUserDTO
	if err := c.BodyParser(&createUserDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	validations := validator.New()
	err := validations.Struct(createUserDTO)
	if err != nil {
		errors := make([]string, 0)
		for _, err := range err.(validator.ValidationErrors) {
			errors = append(errors, err.Error())
		}
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{"error": errors})
	}

	ctx := context.WithValue(c.Context(), "user_id", currentUser.ID)
	user, err := uc.userService.CreateUserAdmin(ctx, createUserDTO)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}
	return c.Status(fiber.StatusCreated).JSON(user)
}

func (uc *UserController) DeleteUser(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)
	userID := c.Params("id")

	if !guards.IsAdmin(currentUser) || currentUser.ID == userID {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}
	ctx := context.WithValue(c.Context(), "user_id", currentUser.ID)
	err := uc.userService.DeleteUser(ctx, userID)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}
	return c.SendStatus(fiber.StatusNoContent)
}
