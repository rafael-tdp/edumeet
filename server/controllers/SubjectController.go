package controllers

import (
	"edumeet/dtos"
	"edumeet/services"

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

	if err := c.BodyParser(&subjectDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	subject, err := sc.subjectService.Create(subjectDTO)

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusCreated).JSON(subject)
}

func (sc *SubjectController) Delete(c *fiber.Ctx) error {
	id, err := ulid.Parse(c.Params("id"))

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}
	errDelete := sc.subjectService.Delete(id.String())

	if errDelete != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
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
