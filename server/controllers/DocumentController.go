package controllers

import (
	"edumeet/dtos"
	"edumeet/services"

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
	if err := c.BodyParser(&documentDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	validations := validator.New()
	err = validations.Struct(documentDTO)
	if err != nil {
		errors := make([]string, 0)
		for _, err := range err.(validator.ValidationErrors) {
			errors = append(errors, err.Error())
		}
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{"error": errors})
	}

	document, err := uc.documentService.CreateDocument(documentDTO)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusCreated).JSON(document)
}
