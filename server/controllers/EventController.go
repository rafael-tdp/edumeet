package controllers

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/guards"
	"edumeet/services"

	customValidators "edumeet/validator"

	"github.com/go-playground/validator/v10"
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

	ctx := context.WithValue(c.Context(), "user_id", currentUser.ID)

	validations := validator.New()
	validations.RegisterValidation("isAfterNow", customValidators.IsAfterNow)
	validations.RegisterValidation("isBefore", customValidators.IsBefore)

	errors, err := customValidators.ValidateDTO(validations, &eventDTO)

	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"error": "Erreur de validation interne",
		})
	}
	if len(errors) > 0 {
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{
			"errors": errors,
		})
	}

	remoteEvent, err := ec.eventservice.CreateEvent(ctx, eventDTO, currentUser.ID)

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusCreated).JSON(remoteEvent)
}

func (ec *EventController) DeleteEvent(c *fiber.Ctx) error {

	eventID, errParse := ulid.Parse(c.Params("id"))

	currentUser := c.Locals("user").(*ent.User)

	event, errGetEvent := ec.eventservice.GetEvent(eventID.String())

	if errGetEvent != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": errGetEvent.Error()})
	}

	if !guards.CanAuthorize(currentUser, event) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}

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

	currentUser := c.Locals("user").(*ent.User)

	event, errGetEvent := ec.eventservice.GetEvent(eventID.String())

	if errGetEvent != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": errGetEvent.Error()})
	}

	if !guards.CanAuthorize(currentUser, event) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}

	var eventDTO dtos.EventDTO

	if err := c.BodyParser(&eventDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	ctx := context.WithValue(c.Context(), "user_id", c.Locals("user").(*ent.User).ID)

	validations := validator.New()
	validations.RegisterValidation("isAfterNow", customValidators.IsAfterNow)
	validations.RegisterValidation("isBefore", customValidators.IsBefore)

	errors, err := customValidators.ValidateDTO(validations, &eventDTO)

	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"error": "Erreur de validation interne",
		})
	}
	if len(errors) > 0 {
		return c.Status(fiber.StatusUnprocessableEntity).JSON(fiber.Map{
			"errors": errors,
		})
	}

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

func (ec *EventController) GetCurrentUserEvents(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)

	events, err := ec.eventservice.GetEventsByUser(currentUser.ID)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}
	return c.Status(fiber.StatusOK).JSON(events)
}

func (ec *EventController) GetEventWithDetails(c *fiber.Ctx) error {
	eventID, err := ulid.Parse(c.Params("id"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	event, err := ec.eventservice.GetEventWithDetails(eventID.String())
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}
	return c.Status(fiber.StatusOK).JSON(event)
}
