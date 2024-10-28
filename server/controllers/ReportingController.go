package controllers

import (
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/services"

	"github.com/go-playground/validator/v10"
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
	reportingId, err := ulid.Parse(c.Params("id"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}
	reporting, err := uc.reportingService.GetReportingById(reportingId.String())
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "Reporting not found"})
	}
	return c.Status(fiber.StatusNotImplemented).JSON(reporting)
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

	if reportingUser.Role != "ADMIN" && reportingUser.Role != "SUPERADMIN" && reporting.UserID != reportingUser.ID {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "Unauthorized"})
	}

	err = uc.reportingService.DeleteReporting(reportingId.String())

	return c.Status(fiber.StatusNoContent).JSON(fiber.Map{})
}

func (uc *ReportingController) CreateReporting(c *fiber.Ctx) error {
	var reportingDTO dtos.ReportingDTO
	if err := c.BodyParser(&reportingDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	validations := validator.New()
	err := validations.Struct(reportingDTO)
	if err != nil {
		errors := make([]string, 0)
		for _, err := range err.(validator.ValidationErrors) {
			errors = append(errors, err.Error())
		}
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{"error": errors})
	}

	reportingUser := c.Locals("user").(*ent.User)
	reportingDTO.UserID = reportingUser.ID

	reporting, err := uc.reportingService.CreateReporting(reportingDTO)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusCreated).JSON(reporting)
}
