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

func (sc *SubjectController) GetSubjects(c *fiber.Ctx) error {
	subjects, err := sc.subjectService.GetSubjects()

	if err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": err.Error()})
	}

	return c.JSON(subjects)
}

func (sc *SubjectController) AddUserToSubject(c *fiber.Ctx) error {
	subjectID, err := ulid.Parse(c.Params("id"))

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	user := c.Locals("user").(*ent.User)

	errAddUser := sc.subjectService.AddUserToSubject(subjectID.String(), user.ID)

	if errAddUser != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": errAddUser.Error()})
	}

	return c.SendStatus(fiber.StatusNoContent)
}

func (sc *SubjectController) RemoveUserFromSubject(c *fiber.Ctx) error {
	subjectID, err := ulid.Parse(c.Params("id"))

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	user := c.Locals("user").(*ent.User)

	errRemoveUser := sc.subjectService.RemoveUserFromSubject(subjectID.String(), user.ID)

	if errRemoveUser != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": errRemoveUser.Error()})
	}

	return c.SendStatus(fiber.StatusNoContent)
}
