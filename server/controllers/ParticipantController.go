package controllers

import (
	"edumeet/services"
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
