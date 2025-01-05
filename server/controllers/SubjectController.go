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

type SubjectController struct {
	subjectService *services.SubjectService
	emailService   *services.EmailService
}

func NewSubjectController(subjectService *services.SubjectService, emailService *services.EmailService) *SubjectController {
	return &SubjectController{
		subjectService: subjectService,
		emailService:   emailService,
	}
}

// Create creates a new subject
// @Summary Create Subject
// @Description Creates a new subject after validating the data.
// @Tags Subjects
// @Accept json
// @Produce json
// @Param subject body dtos.SubjectDTO true "Subject Data"
// @Security AdminAuth
// @Success 201 {object} ent.Subject "Created Subject"
// @Failure 400 {object} map[string]string "Bad Request"
// @Failure 422 {object} map[string][]string "Validation errors"
// @Failure 403 {object} map[string]string "Forbidden"
// @Router /subjects [post]
func (sc *SubjectController) Create(c *fiber.Ctx) error {

	var subjectDTO dtos.SubjectDTO
	currentUser := c.Locals("user").(*ent.User)
	if !guards.IsAdmin(currentUser) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}

	if err := c.BodyParser(&subjectDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	validations := validator.New()
	err := validations.Struct(subjectDTO)
	if err != nil {
		errors := make([]string, 0)
		for _, err := range err.(validator.ValidationErrors) {
			errors = append(errors, err.Error())
		}
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{"error": errors})
	}

	subject, err := sc.subjectService.Create(subjectDTO)

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusCreated).JSON(subject)
}

// Update updates an existing subject
// @Summary Update Subject
// @Description Updates an existing subject identified by ID.
// @Tags Subjects
// @Accept json
// @Produce json
// @Param id path string true "Subject ID"
// @Param subject body dtos.SubjectDTO true "Subject Data"
// @Security AdminAuth
// @Success 200 {object} ent.Subject "Updated Subject"
// @Failure 400 {object} map[string]string "Bad Request"
// @Failure 403 {object} map[string]string "Forbidden"
// @Failure 404 {object} map[string]string "Not Found"
// @Router /subjects/{id} [put]
func (sc *SubjectController) Update(c *fiber.Ctx) error {
	id, err := ulid.Parse(c.Params("id"))

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	var subjectDTO dtos.SubjectDTO

	currentUser := c.Locals("user").(*ent.User)
	if !guards.IsAdmin(currentUser) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}

	if err := c.BodyParser(&subjectDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	validations := validator.New()
	err = validations.Struct(subjectDTO)
	if err != nil {
		errors := make([]string, 0)
		for _, err := range err.(validator.ValidationErrors) {
			errors = append(errors, err.Error())
		}
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{"error": errors})
	}

	subject, err := sc.subjectService.Update(id.String(), subjectDTO)

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.JSON(subject)
}

// Delete deletes an existing subject
// @Summary Delete Subject
// @Description Deletes an existing subject identified by ID.
// @Tags Subjects
// @Param id path string true "Subject ID"
// @Security AdminAuth
// @Success 204 {object} nil "No Content"
// @Failure 400 {object} map[string]string "Bad Request"
// @Failure 403 {object} map[string]string "Forbidden"
// @Failure 404 {object} map[string]string "Not Found"
// @Router /subjects/{id} [delete]
func (sc *SubjectController) Delete(c *fiber.Ctx) error {
	id, err := ulid.Parse(c.Params("id"))

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}
	currentUser := c.Locals("user").(*ent.User)
	if !guards.IsAdmin(currentUser) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}

	errDelete := sc.subjectService.Delete(id.String())

	if errDelete != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": errDelete.Error()})
	}

	return c.SendStatus(fiber.StatusNoContent)
}

// GetSubjects returns a list of all subjects
// @Summary Get Subjects
// @Description Retrieves all subjects in the system.
// @Tags Subjects
// @Produce json
// @Success 200 {array} ent.Subject "List of Subjects"
// @Failure 404 {object} map[string]string "Not Found"
// @Router /subjects [get]
func (sc *SubjectController) GetSubjects(c *fiber.Ctx) error {

	page := c.QueryInt("page", 1)
	if page <= 0 {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid page parameter"})
	}

	perPage := c.QueryInt("per_page", 99999)
	if perPage <= 0 {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid per_page parameter"})
	}

	offset := (page - 1) * perPage
	subjects, err := sc.subjectService.GetSubjects(perPage, offset)

	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": err.Error()})
	}

	return c.JSON(subjects)
}
