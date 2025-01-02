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
	aiService      *services.AIService
	eventService   *services.EventService
	subjectService *services.SubjectService
}

func NewAIController(aiService *services.AIService, eventService *services.EventService, subjectService *services.SubjectService) *AIController {
	return &AIController{
		aiService:      aiService,
		eventService:   eventService,
		subjectService: subjectService,
	}
}

// @Summary Generate Exercise
// @Description Generate an exercise based on the event's title, description, and subjects
// @Tags AI
// @Accept json
// @Produce json
// @Param id path string true "Event ID"
// @Security BearerAuth
// @Success 200 {object} map[string]interface{} "Success: Generated exercise"
// @Failure 400 {object} map[string]interface{} "Bad Request: Invalid ID"
// @Failure 403 {object} map[string]interface{} "Forbidden: Not authorized"
// @Failure 404 {object} map[string]interface{} "Not Found: Event not found"
// @Failure 500 {object} map[string]interface{} "Internal Server Error: Unable to generate exercise"
// @Router /ai/generate-exo/{id} [post]
func (ai *AIController) GenerateExo(c *fiber.Ctx) error {
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
	var subjectsName string
	for _, subjectIds := range event.Subjects {
		subject, err := ai.subjectService.GetSubject(subjectIds)
		if err != nil {
			return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "Subject not found"})
		}

		subjectsName += subject.Name + ", "
	}

	statement := `Génère moi des exercices sur en prenant en compte le titre suivant ` + event.Title + ` la description suivante : ` + event.Description
	statement += ` et les matière suivantes : ` + subjectsName
	exo, err := ai.aiService.GenerateExo(statement)
	if err != nil {
		return c.Status(500).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	return c.JSON(fiber.Map{
		"exo": exo,
	})
}

// @Summary Generate Correction
// @Description Generate a correction for a given exercise from the event
// @Tags AI
// @Accept json
// @Produce json
// @Param id path string true "Event ID"
// @Param exercise body dtos.AICorrectionDTO true "Exercise for correction"
// @Security BearerAuth
// @Success 200 {object} map[string]interface{} "Success: Generated correction"
// @Failure 400 {object} map[string]interface{} "Bad Request: Invalid ID or body parsing error"
// @Failure 422 {object} map[string]interface{} "Unprocessable Entity: Validation errors"
// @Failure 403 {object} map[string]interface{} "Forbidden: Not authorized"
// @Failure 404 {object} map[string]interface{} "Not Found: Event not found"
// @Failure 500 {object} map[string]interface{} "Internal Server Error: Unable to generate correction"
// @Router /ai/generate-correction/{id} [post]
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

// @Summary Save Generated Document
// @Description Save the generated document from an AI operation
// @Tags AI
// @Accept json
// @Produce json
// @Param document body dtos.AIDocumentSaveDTO true "Document information for saving"
// @Security BearerAuth
// @Success 200 {object} map[string]interface{} "Success: Document saved"
// @Failure 400 {object} map[string]interface{} "Bad Request: Body parsing error"
// @Failure 422 {object} map[string]interface{} "Unprocessable Entity: Validation errors"
// @Failure 403 {object} map[string]interface{} "Forbidden: Not authorized"
// @Failure 500 {object} map[string]interface{} "Internal Server Error: Unable to save document"
// @Router /ai/save-document [post]
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
