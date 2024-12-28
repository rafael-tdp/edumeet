package controllers

import (
	"edumeet/ent"
	"edumeet/guards"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

type StatController struct {
	statService *services.StatService
}

func NewStatController(statService *services.StatService) *StatController {
	return &StatController{
		statService: statService,
	}
}

func (sc *StatController) GetStats(c *fiber.Ctx) error {
	stats, err := sc.statService.GetStats()
	currentUser := c.Locals("user").(*ent.User)

	if !guards.IsAdmin(currentUser) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}

	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}

	return c.JSON(stats)
}
