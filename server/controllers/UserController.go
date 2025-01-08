package controllers

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/enums"
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

// @Summary Get current user information
// @Description Retrieve the information of the currently authenticated user
// @Tags User
// @Accept json
// @Produce json
// @Success 200 {object} dtos.UserDTO "Success: Current user information"
// @Failure 401 {object} map[string]string "Unauthorized: Invalid token or user not found"
// @Router /me [get]
func (uc *UserController) Me(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)
	userDTO, err := uc.userService.GetUser(currentUser.ID)
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": err.Error()})
	}
	return c.JSON(userDTO)
}

// @Summary Get user information by ID
// @Description Retrieve the information of a user by their ID
// @Tags User
// @Accept json
// @Produce json
// @Param id path string true "User ID"
// @Success 200 {object} dtos.UserDTO "Success: User information"
// @Failure 400 {object} map[string]string "Bad Request: Invalid ID format"
// @Failure 404 {object} map[string]string "Not Found: User not found"
// @Router /user/information/{id} [get]
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

// @Summary Verify user email code
// @Description Verify the user email using the provided verification code
// @Tags User
// @Accept json
// @Produce json
// @Param body body dtos.VerifyCodeDTO true "Verification Code"
// @Success 200 {object} map[string]string "Success: Id verified successfully"
// @Failure 400 {object} map[string]string "Bad Request: Invalid verification code"
// @Failure 500 {object} map[string]string "Internal Server Error: Error processing verification"
// @Router /user/verify [post]
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

// @Summary Validate user activation code
// @Description Validate user activation code for account activation
// @Tags User
// @Accept json
// @Produce json
// @Param body body dtos.ValidateUserDTO true "Activation Code"
// @Success 200 {object} map[string]string "Success: User activated successfully"
// @Failure 400 {object} map[string]string "Bad Request: Invalid activation code"
// @Failure 500 {object} map[string]string "Internal Server Error: Error processing validation"
// @Router /user/validate-user [post]
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

// @Summary Update user information
// @Description Update the information of a user based on their ID
// @Tags User
// @Accept json
// @Produce json
// @Param id path string true "User ID"
// @Param body body dtos.UpdateUserDTO true "User Information"
// @Success 200 {object} dtos.UserDTO "Success: User information updated"
// @Failure 400 {object} map[string]string "Bad Request: Invalid ID or data"
// @Failure 422 {object} map[string]interface{} "Unprocessable Entity: Validation errors"
// @Failure 500 {object} map[string]string "Internal Server Error: Error updating user"
// @Router /user/{id} [put]
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

// @Summary Get user subjects
// @Description Retrieve subjects associated with the currently authenticated user
// @Tags User
// @Accept json
// @Produce json
// @Success 200 {array} dtos.SubjectDTO "Success: List of user subjects"
// @Failure 500 {object} map[string]string "Internal Server Error: Error retrieving subjects"
// @Router /user/subjects [get]
func (uc *UserController) GetUserSubjects(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)
	subjects, err := uc.userService.GetUserSubjects(currentUser.ID)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}
	return c.JSON(subjects)
}

// @Summary Update user subjects
// @Description Update the subjects associated with the currently authenticated user
// @Tags User
// @Accept json
// @Produce json
// @Param body body []string true "List of subjects"
// @Success 200 {object} map[string]string "Success: Subjects updated"
// @Failure 400 {object} map[string]string "Bad Request: Invalid subjects"
// @Failure 500 {object} map[string]string "Internal Server Error: Error updating subjects"
// @Router /user/subjects/update [put]
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

// @Summary Create friendship
// @Description Create a friendship between users
// @Tags User
// @Accept json
// @Produce json
// @Param body body dtos.CreateFriendshipDTO true "Friendship details"
// @Success 201 {object} dtos.FriendshipDTO "Success: Friendship created"
// @Failure 400 {object} map[string]string "Bad Request: Invalid friendship data"
// @Router /user/friendship [post]
func (uc *UserController) CreateFriendship(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)
	var friendshipDTO dtos.CreateFriendshipDTO
	if err := c.BodyParser(&friendshipDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	ctx := context.WithValue(c.Context(), "user_id", currentUser.ID)

	friendship, err := uc.userService.CreateFriendship(ctx, currentUser.ID, friendshipDTO)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}
	return c.Status(fiber.StatusCreated).JSON(friendship)
}

// @Summary Accept friendship
// @Description Accept a pending friendship request
// @Tags User
// @Accept json
// @Produce json
// @Param id path string true "Friendship ID"
// @Success 200 {object} dtos.FriendshipDTO "Success: Friendship accepted"
// @Failure 400 {object} map[string]string "Bad Request: Invalid friendship ID"
// @Router /user/friendship/{id} [put]
func (uc *UserController) AcceptFriendship(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)
	friendshipID := c.Params("id")

	friendship, err := uc.userService.UpdateFriendship(friendshipID, currentUser.ID)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}
	return c.Status(fiber.StatusOK).JSON(friendship)
}

// @Summary Get friendships
// @Description Retrieve a list of the user's friendships
// @Tags User
// @Accept json
// @Produce json
// @Param status query string false "Friendship status" (default: "PENDING")
// @Success 200 {array} dtos.FriendshipDTO "Success: List of friendships"
// @Failure 500 {object} map[string]string "Internal Server Error: Error retrieving friendships"
// @Router /user/friendships [get]
func (uc *UserController) GetFriendships(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)

	status := c.Query("status", string(enums.FriendAll))

	friendships, err := uc.userService.GetFriendships(currentUser.ID, status)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}
	return c.JSON(friendships)
}

// @Summary Delete friendship
// @Description Delete a friendship between users
// @Tags User
// @Accept json
// @Produce json
// @Param id path string true "Friendship ID"
// @Success 204 {object} map[string]string "Success: Friendship deleted"
// @Failure 400 {object} map[string]string "Bad Request: Invalid friendship ID"
// @Router /user/friendship/{id} [delete]
func (uc *UserController) DeleteFriendship(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)
	friendshipID := c.Params("id")
	err := uc.userService.DeleteFriendship(friendshipID, currentUser.ID)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}
	return c.Status(fiber.StatusNoContent).JSON(fiber.Map{"message": "Friendship deleted successfully"})
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

func (uc *UserController) LikeDocument(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)
	documentID := c.Params("id")

	ctx := context.WithValue(c.Context(), "user_id", currentUser.ID)
	err := uc.userService.LikeDocument(ctx, currentUser.ID, documentID)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}
	return c.SendStatus(fiber.StatusOK)
}

func (uc *UserController) UnlikeDocument(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)
	documentID := c.Params("id")

	ctx := context.WithValue(c.Context(), "user_id", currentUser.ID)
	err := uc.userService.UnlikeDocument(ctx, currentUser.ID, documentID)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}
	return c.SendStatus(fiber.StatusOK)
}

func (uc *UserController) GetLikedDocuments(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)

	documents, err := uc.userService.GetLikedDocuments(currentUser.ID)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}
	return c.JSON(documents)
}
