package controllers

import (
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

func (uc *BadgeController) GetBadges(c *fiber.Ctx) error {
	badges, err := uc.badgeService.GetBadges()
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "Badges not found"})
	}
	return c.Status(fiber.StatusOK).JSON(badges)
}

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

func (uc *BadgeController) DeleteBadge(c *fiber.Ctx) error {
	badgeId, err := ulid.Parse(c.Params("id"))
	currentUser := c.Locals("user").(*ent.User)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	if !guards.IsAdmin(currentUser) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}

	badgeUser := c.Locals("user").(*ent.User)
	badge, err := uc.badgeService.GetBadgeById(badgeId.String())
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "Badge not found"})
	}

	if badgeUser.Role != "ADMIN" && badgeUser.Role != "SUPERADMIN" {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "Unauthorized"})
	}

	err = uc.badgeService.DeleteBadge(badge.ID)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusNoContent).JSON(fiber.Map{})
}

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

	badge, err := uc.badgeService.CreateBadge(badgeDTO)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusCreated).JSON(badge)
}

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

	badge, err := uc.badgeService.GetBadgeById(badgeId.String())
	if err != nil {
		badge, err = uc.badgeService.CreateBadge(badgeDTO)
		if err != nil {
			return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
		}
		return c.Status(fiber.StatusCreated).JSON(badge)
	}
	updatedBadge, err := uc.badgeService.UpdateBadge(badge.ID, badgeDTO)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusOK).JSON(updatedBadge)
}
