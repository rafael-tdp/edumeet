package controllers

import (
	"edumeet/ent"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
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

	eventID := c.Params("eventID")

	user := c.Locals("user").(*ent.User)
	return pc.participantService.RequestParticipant(eventID, user.ID)
}

func (pc *ParticipantController) AcceptParticipant(c *fiber.Ctx) error {

	participantID := c.Params("participantID")
	return pc.participantService.AcceptParticipant(participantID)
}
