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

type BadgeController struct {
	badgeService *services.BadgeService
}

func NewBadgeController(badgeService *services.BadgeService) *BadgeController {
	return &BadgeController{
		badgeService: badgeService,
	}
}

// GetBadges returns all badges
// @Summary Get all badges
// @Description Retrieve a list of all badges
// @Tags Badge
// @Accept json
// @Produce json
// @Success 200 {array} dtos.BadgeDTO "Success: List of badges"
// @Failure 404 {object} map[string]string "Error: Badges not found"
// @Router /badge [get]
func (uc *BadgeController) GetBadges(c *fiber.Ctx) error {

	page := c.QueryInt("page", 1)
	if page <= 0 {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid page parameter"})
	}

	perPage := c.QueryInt("per_page", 99999)
	if perPage <= 0 {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid per_page parameter"})
	}

	offset := (page - 1) * perPage

	badges, err := uc.badgeService.GetBadges(perPage, offset)
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "Badges not found"})
	}

	if len(badges) == 0 {
		return c.JSON([]dtos.BadgeDTO{})
	}

	return c.JSON(badges)
}

// GetBadge returns a single badge by ID
// @Summary Get a single badge by ID
// @Description Retrieve a badge by its ID
// @Tags Badge
// @Accept json
// @Produce json
// @Param id path string true "Badge ID"
// @Success 200 {object} dtos.BadgeDTO "Success: Badge data"
// @Failure 400 {object} map[string]string "Error: Invalid ID"
// @Failure 404 {object} map[string]string "Error: Badge not found"
// @Router /badge/{id} [get]
func (uc *BadgeController) GetBadge(c *fiber.Ctx) error {
	badgeId, err := ulid.Parse(c.Params("id"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}
	badge, err := uc.badgeService.GetBadgeById(badgeId.String())
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "Badge not found"})
	}
	return c.Status(fiber.StatusNotImplemented).JSON(badge)
}

// DeleteBadge deletes a badge by ID
// @Summary Delete a badge by ID
// @Description Delete a badge from the system by its ID
// @Tags Badge
// @Accept json
// @Produce json
// @Param id path string true "Badge ID"
// @Security BearerAuth
// @Success 204 {object} map[string]string "Success: No Content"
// @Failure 400 {object} map[string]string "Error: Invalid ID"
// @Failure 403 {object} map[string]string "Error: Forbidden"
// @Failure 404 {object} map[string]string "Error: Badge not found"
// @Failure 401 {object} map[string]string "Error: Unauthorized"
// @Router /badge/{id} [delete]
func (uc *BadgeController) DeleteBadge(c *fiber.Ctx) error {
	badgeId, err := ulid.Parse(c.Params("id"))
	currentUser := c.Locals("user").(*ent.User)

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	if !guards.IsAdmin(currentUser) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}

	badge, err := uc.badgeService.GetBadgeById(badgeId.String())
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "Badge not found"})
	}

	err = uc.badgeService.DeleteBadge(badge.ID)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusNoContent).JSON(fiber.Map{})
}

// CreateBadge creates a new badge
// @Summary Create a new badge
// @Description Create a new badge and add it to the system
// @Tags Badge
// @Accept json
// @Produce json
// @Param badge body dtos.BadgeDTO true "Badge Data"
// @Security BearerAuth
// @Success 201 {object} dtos.BadgeDTO "Success: Badge created"
// @Failure 400 {object} map[string]string "Error: Invalid data"
// @Failure 401 {object} map[string]string "Error: Unauthorized"
// @Failure 422 {object} map[string]interface{} "Error: Validation failed"
// @Router /badge [post]
func (uc *BadgeController) CreateBadge(c *fiber.Ctx) error {
	var badgeDTO dtos.BadgeDTO
	badgeUser := c.Locals("user").(*ent.User)
	if !guards.IsAdmin(badgeUser) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}

	if err := c.BodyParser(&badgeDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	validations := validator.New()
	err := validations.Struct(badgeDTO)
	if err != nil {
		errors := make([]string, 0)
		for _, err := range err.(validator.ValidationErrors) {
			errors = append(errors, err.Error())
		}
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{"error": errors})
	}

	if badgeUser.Role != "ADMIN" && badgeUser.Role != "SUPERADMIN" {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "Unauthorized"})
	}
	ctx := context.WithValue(c.Context(), "user_id", badgeUser.ID)
	badge, err := uc.badgeService.CreateBadge(ctx, badgeDTO)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusCreated).JSON(badge)
}

// UpdateBadge updates an existing badge by ID
// @Summary Update a badge by ID
// @Description Update the details of an existing badge
// @Tags Badge
// @Accept json
// @Produce json
// @Param id path string true "Badge ID"
// @Param badge body dtos.BadgeDTO true "Updated Badge Data"
// @Security BearerAuth
// @Success 200 {object} dtos.BadgeDTO "Success: Badge updated"
// @Failure 400 {object} map[string]string "Error: Invalid ID or data"
// @Failure 401 {object} map[string]string "Error: Unauthorized"
// @Failure 404 {object} map[string]string "Error: Badge not found"
// @Router /badge/{id} [put]
func (uc *BadgeController) UpdateBadge(c *fiber.Ctx) error {
	badgeId, err := ulid.Parse(c.Params("id"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	var badgeDTO dtos.BadgeDTO
	if err := c.BodyParser(&badgeDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	validations := validator.New()
	err = validations.Struct(badgeDTO)
	if err != nil {
		errors := make([]string, 0)
		for _, err := range err.(validator.ValidationErrors) {
			errors = append(errors, err.Error())
		}
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{"error": errors})
	}

	badgeUser := c.Locals("user").(*ent.User)

	if badgeUser.Role != "ADMIN" && badgeUser.Role != "SUPERADMIN" {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "Unauthorized"})
	}
	ctx := context.WithValue(c.Context(), "user_id", badgeUser.ID)
	badge, err := uc.badgeService.GetBadgeById(badgeId.String())
	if err != nil {
		badge, err = uc.badgeService.CreateBadge(ctx, badgeDTO)
		if err != nil {
			return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
		}
		return c.Status(fiber.StatusCreated).JSON(badge)
	}

	updatedBadge, err := uc.badgeService.UpdateBadge(ctx, badge.ID, badgeDTO)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusOK).JSON(updatedBadge)
}
