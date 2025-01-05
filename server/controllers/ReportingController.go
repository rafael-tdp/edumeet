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

type ReportingController struct {
	reportingService *services.ReportingService
}

func NewReportingController(reportingService *services.ReportingService) *ReportingController {
	return &ReportingController{
		reportingService: reportingService,
	}
}

// @Summary Get Reporting by ID
// @Description Retrieve reporting details based on a given ID
// @Tags Reporting
// @Accept json
// @Produce json
// @Param id path string true "Reporting ID"
// @Success 200 {object} map[string]interface{} "Success: Reporting details"
// @Failure 400 {object} map[string]string "Bad Request: Invalid ID"
// @Failure 404 {object} map[string]string "Not Found: Reporting not found"
// @Router /reporting/{id} [get]
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

// @Summary Create a new Reporting
// @Description Create a new reporting based on the provided data
// @Tags Reporting
// @Accept json
// @Produce json
// @Param reporting body dtos.ReportingDTO true "Reporting DTO"
// @Success 201 {object} map[string]interface{} "Success: Reporting created"
// @Failure 400 {object} map[string]string "Bad Request: Invalid input data"
// @Failure 422 {object} map[string]interface{} "Unprocessable Entity: Validation errors"
// @Router /reporting [post]
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

// @Summary Delete a Reporting by ID
// @Description Delete reporting based on a given ID
// @Tags Reporting
// @Accept json
// @Produce json
// @Param id path string true "Reporting ID"
// @Success 204 {object} map[string]interface{} "Success: Reporting deleted"
// @Failure 400 {object} map[string]string "Bad Request: Invalid ID"
// @Failure 404 {object} map[string]string "Not Found: Reporting not found"
// @Failure 401 {object} map[string]string "Unauthorized: Unauthorized access"
// @Router /reporting/{id} [delete]
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
	ctx := context.WithValue(c.Context(), "user_id", reportingUser.ID)
	reportingDTO.UserID = reportingUser.ID

	reporting, err := uc.reportingService.CreateReporting(ctx, reportingDTO)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusCreated).JSON(reporting)
}
