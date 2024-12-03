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

type AIController struct {
	aiService    *services.AIService
	eventService *services.EventService
}

func NewAIController(aiService *services.AIService, eventService *services.EventService) *AIController {
	return &AIController{
		aiService:    aiService,
		eventService: eventService,
	}
}

func (ai *AIController) GenerateExo(c *fiber.Ctx) error {
	var aiDTO dtos.AIExerciseDTO
	eventID, errParse := ulid.Parse(c.Params("id"))
	if errParse != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	user := c.Locals("user").(*ent.User)
	event, err := ai.eventService.GetEvent(eventID.String())
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "Event not found"})
	}
	if !guards.CanAuthorize(user, event) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}
	if err := c.BodyParser(&aiDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	validations := validator.New()
	err = validations.Struct(aiDTO)
	if err != nil {
		errors := make([]string, 0)
		for _, err := range err.(validator.ValidationErrors) {
			errors = append(errors, err.Error())
		}
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{"error": errors})
	}

	exo, err := ai.aiService.GenerateExo(aiDTO.Statement)
	if err != nil {
		return c.Status(500).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	return c.JSON(fiber.Map{
		"exo": exo,
	})
}

func (ai *AIController) GenerateCorrection(c *fiber.Ctx) error {
	var aiDTO dtos.AICorrectionDTO
	eventID, errParse := ulid.Parse(c.Params("id"))
	if errParse != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	user := c.Locals("user").(*ent.User)
	event, err := ai.eventService.GetEvent(eventID.String())
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "Event not found"})
	}
	if !guards.CanAuthorize(user, event) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}
	if err := c.BodyParser(&aiDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	validations := validator.New()
	err = validations.Struct(aiDTO)
	if err != nil {
		errors := make([]string, 0)
		for _, err := range err.(validator.ValidationErrors) {
			errors = append(errors, err.Error())
		}
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{"error": errors})
	}

	correction, err := ai.aiService.GenerateCorrection(aiDTO.Exercise)
	if err != nil {
		return c.Status(500).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	return c.JSON(fiber.Map{
		"correction": correction,
	})
}

func (ai *AIController) SaveGenerateDocument(c *fiber.Ctx) error {
	var aiDocumentDTO dtos.AIDocumentSaveDTO

	currentUser := c.Locals("user").(*ent.User)
	ctx := context.WithValue(c.Context(), "user_id", currentUser.ID)
	if err := c.BodyParser(&aiDocumentDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	validations := validator.New()
	err := validations.Struct(aiDocumentDTO)
	if err != nil {
		errors := make([]string, 0)
		for _, err := range err.(validator.ValidationErrors) {
			errors = append(errors, err.Error())
		}
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{"error": errors})
	}

	event, err := ai.eventService.GetEvent(aiDocumentDTO.EventID)
	if !guards.CanAuthorize(currentUser, event) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}

	err = ai.aiService.SaveGenerateDocument(ctx, aiDocumentDTO)
	if err != nil {
		return c.Status(500).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	return c.JSON(fiber.Map{
		"message": "Document saved successfully",
	})
}
