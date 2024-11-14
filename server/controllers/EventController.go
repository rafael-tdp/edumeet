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

func (ec *EventController) CreateEvent(c *fiber.Ctx) error {

	var eventDTO dtos.EventDTO

	if err := c.BodyParser(&eventDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	currentUser := c.Locals("user").(*ent.User)

	ctx := c.Context()

	remoteEvent, err := ec.eventservice.CreateEvent(ctx, eventDTO, currentUser.ID)

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

func (ec *EventController) GetEvent(c *fiber.Ctx) error {

	eventID, err := ulid.Parse(c.Params("id"))

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	event, err := ec.eventservice.GetEvent(eventID.String())

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusOK).JSON(event)
}

func (ec *EventController) UpdateEvent(c *fiber.Ctx) error {
	eventID, errParse := ulid.Parse(c.Params("id"))

	if errParse != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	var eventDTO dtos.EventDTO

	if err := c.BodyParser(&eventDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	ctx := c.Context()

	remoteEvent, err := ec.eventservice.UpdateEvent(ctx, eventDTO, eventID.String())

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
