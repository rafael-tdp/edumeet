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

// @Summary Get Document
// @Description Retrieve a document by its ID
// @Tags Document
// @Accept json
// @Produce json
// @Param id path string true "Document ID"
// @Success 200 {file} string "Success: Document file"
// @Failure 400 {object} map[string]string "Bad Request: Invalid ID"
// @Failure 404 {object} map[string]string "Not Found: Document not found"
// @Router /document/{id} [get]
func (uc *DocumentController) GetDocument(c *fiber.Ctx) error {

	currentUser := c.Locals("user").(*ent.User)

	documentId, err := ulid.Parse(c.Params("id"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}
	document, err := uc.documentService.GetDocumentById(documentId.String(), currentUser.ID)
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "Document not found"})
	}

	return c.SendFile(document.Path)
}

// @Summary Get Document Details
// @Description Retrieve details of a document by its ID
// @Tags Document
// @Accept json
// @Produce json
// @Param id path string true "Document ID"
// @Success 200 {object} map[string]interface{} "Success: Document details"
// @Failure 400 {object} map[string]string "Bad Request: Invalid ID"
// @Failure 404 {object} map[string]string "Not Found: Document not found"
// @Router /document/details/{id} [get]
func (uc *DocumentController) GetDocumentDetails(c *fiber.Ctx) error {

	currentUser := c.Locals("user").(*ent.User)

	documentId, err := ulid.Parse(c.Params("id"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}
	document, err := uc.documentService.GetDocumentById(documentId.String(), currentUser.ID)
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "Document not found"})
	}

	return c.JSON(document)
}

// @Summary Delete Document
// @Description Delete a document by its ID
// @Tags Document
// @Accept json
// @Produce json
// @Param id path string true "Document ID"
// @Success 204 {object} map[string]interface{} "Success: Document deleted"
// @Failure 400 {object} map[string]string "Bad Request: Invalid ID"
// @Failure 404 {object} map[string]string "Not Found: Document not found"
// @Router /document/{id} [delete]
func (uc *DocumentController) DeleteDocument(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)
	documentId, err := ulid.Parse(c.Params("id"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	document, err := uc.documentService.GetDocumentById(documentId.String(), currentUser.ID)
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "Document not found"})
	}

	err = uc.documentService.DeleteDocument(document.ID)

	return c.Status(fiber.StatusNoContent).JSON(fiber.Map{})
}

// @Summary Create Document
// @Description Create a new document
// @Tags Document
// @Accept multipart/form-data
// @Produce json
// @Param file formData file true "File"
// @Param event_id formData string true "Event ID"
// @Param message_id formData string true "Message ID"
// @Param type formData string true "Document Type"
// @Success 201 {object} map[string]interface{} "Success: Document created"
// @Failure 400 {object} map[string]string "Bad Request: Missing or invalid data"
// @Failure 422 {object} map[string]interface{} "Unprocessable Entity: Validation errors"
// @Router /document [post]
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

// @Summary Get Event Documents
// @Description Retrieve all documents related to an event
// @Tags Document
// @Accept json
// @Produce json
// @Param id path string true "Event ID"
// @Success 200 {array} map[string]interface{} "Success: Event documents"
// @Failure 400 {object} map[string]string "Bad Request: Invalid ID"
// @Failure 404 {object} map[string]string "Not Found: Documents not found"
// @Router /event/{id}/documents [get]
func (uc *DocumentController) GetEventDocuments(c *fiber.Ctx) error {
	eventId, err := ulid.Parse(c.Params("id"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	documents, err := uc.documentService.GetEventDocuments(eventId.String())
	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "Documents not found"})
	}

	return c.JSON(documents)
}
