package controllers

import (
	"edumeet/dtos"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
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
