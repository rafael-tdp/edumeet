package controllers

import (
	"edumeet/dtos"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

type EventController struct {
	eventservice *services.EventService
	emailService *services.EmailService
}

func NewEventController(eventservice *services.EventService, emailService *services.EmailService) *EventController {
	return &EventController{
		eventservice: eventservice,
		emailService: emailService,
	}
}

func (ec *EventController) CreateRemoteEvent(c *fiber.Ctx) error {

	var remoteEventDTO dtos.RemoteEventDTO

	if err := c.BodyParser(&remoteEventDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	remoteEvent, err := ec.eventservice.CreateRemoteEvent(remoteEventDTO)

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusCreated).JSON(remoteEvent)
}
