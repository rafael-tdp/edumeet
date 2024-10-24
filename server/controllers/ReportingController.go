package controllers

import (
	"edumeet/ent"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
	"github.com/oklog/ulid/v2"
)

type ReportingController struct {
	reportingService *services.ReportingService
}

func NewReportingController(reportingService *services.ReportingService) *ReportingController {
	return &ReportingController{
		reportingService: reportingService,
	}
}

func (uc *ReportingController) GetReporting(c *fiber.Ctx) error {
	return c.Status(fiber.StatusNotImplemented).JSON(fiber.Map{"error": "Not implemented"})
}

func (uc *ReportingController) DeleteReporting(c *fiber.Ctx) error {
	reportingId, err := ulid.Parse(c.Params("id"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}
	reportingUser := c.Locals("user").(*ent.User)
	reporting, err := uc.reportingService.GetReportingById(reportingId.String())
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "Reporting not found"})
	}

	if reportingUser.Role != "ADMIN" && reportingUser.Role != "SUPERADMIN" && reporting.User.ID != reportingUser.ID {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "Unauthorized"})
	}

	err = uc.reportingService.DeleteReporting(reportingId.String())

	return c.Status(fiber.StatusNoContent).JSON(fiber.Map{})
}
