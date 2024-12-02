package controllers

import (
	"edumeet/ent"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
	"github.com/oklog/ulid/v2"
)

type ParticipantController struct {
	participantService *services.ParticipantService
	emailService       *services.EmailService
}

func NewParticipantController(participantService *services.ParticipantService, emailService *services.EmailService) *ParticipantController {
	return &ParticipantController{
		participantService: participantService,
		emailService:       emailService,
	}
}

func (pc *ParticipantController) RequestParticipant(c *fiber.Ctx) error {

	eventID, err := ulid.Parse(c.Params("eventID"))

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error": "Invalid event ID",
		})
	}

	user := c.Locals("user").(*ent.User)
	return pc.participantService.RequestParticipant(eventID.String(), user.ID)
}

func (pc *ParticipantController) AcceptParticipant(c *fiber.Ctx) error {

	statut := c.Params("statut")
	participantID := c.Params("participantID")

	return pc.participantService.ProcessParticipant(participantID, statut)
}
