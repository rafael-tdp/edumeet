package controllers

import (
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
	"github.com/oklog/ulid/v2"
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

	currentUser := c.Locals("user").(*ent.User)

	remoteEvent, err := ec.eventservice.CreateRemoteEvent(remoteEventDTO, currentUser.ID)

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusCreated).JSON(remoteEvent)
}

func (ec *EventController) DeleteEvent(c *fiber.Ctx) error {

	eventID, errParse := ulid.Parse(c.Params("id"))

	if errParse != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	err := ec.eventservice.DeleteEvent(eventID.String())

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.SendStatus(fiber.StatusNoContent)
}

func (ec *EventController) GetRemoteEvent(c *fiber.Ctx) error {

	eventID, err := ulid.Parse(c.Params("id"))

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	remoteEvent, err := ec.eventservice.GetRemoteEvent(eventID.String())

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusOK).JSON(remoteEvent)
}

func (ec *EventController) UpdateRemoteEvent(c *fiber.Ctx) error {
	eventID, errParse := ulid.Parse(c.Params("id"))

	if errParse != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	var remoteEventDTO dtos.RemoteEventDTO

	if err := c.BodyParser(&remoteEventDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	remoteEvent, err := ec.eventservice.UpdateRemoteEvent(eventID.String(), remoteEventDTO)

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusOK).JSON(remoteEvent)
}

func (ec *EventController) GetAllEvents(c *fiber.Ctx) error {
	events, err := ec.eventservice.GetAllEvents()
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}
	return c.Status(fiber.StatusOK).JSON(events)
}

func (ec *EventController) GetCurrentUserEvents(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)

	events, err := ec.eventservice.GetEventsByUser(currentUser.ID)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}
	return c.Status(fiber.StatusOK).JSON(events)
}
