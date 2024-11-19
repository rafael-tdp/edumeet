package controllers

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/services"

	customValidators "edumeet/validator"

	"github.com/go-playground/validator/v10"
	"github.com/gofiber/fiber/v2"
	"github.com/oklog/ulid/v2"
)

type DocumentController struct {
	documentService *services.DocumentService
}

func NewDocumentController(documentService *services.DocumentService) *DocumentController {
	return &DocumentController{
		documentService: documentService,
	}
}

func (uc *DocumentController) GetDocument(c *fiber.Ctx) error {
	documentId, err := ulid.Parse(c.Params("id"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}
	document, err := uc.documentService.GetDocumentById(documentId.String())
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "Document not found"})
	}

	return c.SendFile(document.Path)
}

func (uc *DocumentController) DeleteDocument(c *fiber.Ctx) error {
	documentId, err := ulid.Parse(c.Params("id"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	document, err := uc.documentService.GetDocumentById(documentId.String())
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "Document not found"})
	}

	err = uc.documentService.DeleteDocument(document.ID)

	return c.Status(fiber.StatusNoContent).JSON(fiber.Map{})
}

func (uc *DocumentController) CreateDocument(c *fiber.Ctx) error {
	var documentDTO dtos.DocumentDTO
	file, err := c.FormFile("file")
	if err != nil {
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{"error": "File is required"})
	}
	documentDTO.File = file
	documentDTO.EventID = c.FormValue("event_id")
	documentDTO.MessageID = c.FormValue("message_id")
	documentDTO.Type = c.FormValue("type")
	if err := c.BodyParser(&documentDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}
	currentUser := c.Locals("user").(*ent.User)
	ctx := context.WithValue(c.Context(), "user_id", currentUser.ID)

	validations := validator.New()
	validations.RegisterValidation("maxFileSizeInMB", customValidators.MaxFileSizeInMB(file))
	validations.RegisterValidation("checkEventMessageEmpty", customValidators.CheckEventMessageEmpty)
	validations.RegisterValidation("checkEventMessageFilled", customValidators.CheckEventMessageFilled)

	errors, err := customValidators.ValidateDTO(validations, &documentDTO)

	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"error": "Erreur de validation interne",
		})
	}
	if len(errors) > 0 {
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{
			"errors": errors,
		})
	}

	document, err := uc.documentService.CreateDocument(ctx, documentDTO)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusCreated).JSON(document)
}
