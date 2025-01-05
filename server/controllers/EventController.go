package controllers

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/guards"
	"edumeet/metrics"
	"edumeet/services"
	"edumeet/structures"

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

// CreateEvent creates a new event
// @Summary Create a new event
// @Description Create a new event with the given details
// @Tags Events
// @Accept json
// @Produce json
// @Param event body dtos.EventDTO true "Event Details"
// @Success 201 {object} dtos.EventDTO "Event Created Successfully"
// @Failure 400 {object} map[string]string "Bad Request"
// @Failure 422 {object} map[string]interface{} "Validation Errors"
// @Failure 500 {object} map[string]string "Internal Server Error"
// @Router /events [post]
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
		metrics.EventAttempts.WithLabelValues("failure").Inc()
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	metrics.EventAttempts.WithLabelValues("success").Inc()
	return c.Status(fiber.StatusCreated).JSON(remoteEvent)
}

// DeleteEvent deletes an event by ID
// @Summary Delete an event
// @Description Deletes an event based on the provided ID
// @Tags Events
// @Accept json
// @Produce json
// @Param id path string true "Event ID"
// @Success 204 {object} map[string]string "Success: No Content"
// @Failure 400 {object} map[string]string "Bad Request"
// @Failure 403 {object} map[string]string "Forbidden"
// @Failure 404 {object} map[string]string "Event Not Found"
// @Router /events/{id} [delete]
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

	return c.SendStatus(fiber.StatusOK)
}

// GetEvent retrieves an event by ID
// @Summary Get an event
// @Description Get an event's details based on the provided ID
// @Tags Events
// @Accept json
// @Produce json
// @Param id path string true "Event ID"
// @Success 200 {object} dtos.EventDTO "Event Found"
// @Failure 400 {object} map[string]string "Bad Request"
// @Failure 404 {object} map[string]string "Event Not Found"
// @Router /events/{id} [get]
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

// UpdateEvent updates an existing event by ID
// @Summary Update an event
// @Description Update the details of an event
// @Tags Events
// @Accept json
// @Produce json
// @Param id path string true "Event ID"
// @Param event body dtos.EventDTO true "Updated Event Details"
// @Success 200 {object} dtos.EventDTO "Event Updated Successfully"
// @Failure 400 {object} map[string]string "Bad Request"
// @Failure 403 {object} map[string]string "Forbidden"
// @Failure 404 {object} map[string]string "Event Not Found"
// @Failure 422 {object} map[string]interface{} "Validation Errors"
// @Router /events/{id} [put]
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

// GetAllEvents retrieves a list of events with optional filters
// @Summary Get all events
// @Description Get a list of all events with optional filters
// @Tags Events
// @Accept json
// @Produce json
// @Param type query string false "Event Type" default("all")
// @Param distance query string false "Distance Filter"
// @Param longitude query string false "Longitude Filter"
// @Param latitude query string false "Latitude Filter"
// @Param subjects query string false "Subjects Filter"
// @Success 200 {array} dtos.EventDTO "List of Events"
// @Failure 400 {object} map[string]string "Bad Request"
// @Router /events [get]
func (ec *EventController) GetAllEvents(c *fiber.Ctx) error {

	page := c.QueryInt("page", 1)
	if page <= 0 {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid page parameter"})
	}

	perPage := c.QueryInt("per_page", 99999)
	if perPage <= 0 {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid per_page parameter"})
	}

	offset := (page - 1) * perPage

	eventType := c.Query("type", "all")
	distance := c.Query("distance", "")
	longitude := c.Query("longitude", "")
	latitude := c.Query("latitude", "")
	subjects := c.Query("subjects", "")

	filters := structures.EventFilters{
		Type:      eventType,
		Distance:  distance,
		Longitude: longitude,
		Latitude:  latitude,
		Subjects:  subjects,
	}

	events, err := ec.eventservice.GetFilteredEvents(filters, perPage, offset)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}

	return c.Status(fiber.StatusOK).JSON(events)
}

// GetCurrentUserEvents retrieves events of the current user
// @Summary Get current user's events
// @Description Get a list of events associated with the current user
// @Tags Events
// @Accept json
// @Produce json
// @Success 200 {array} dtos.EventDTO "List of Current User's Events"
// @Failure 400 {object} map[string]string "Bad Request"
// @Router /events/users/current [get]
func (ec *EventController) GetCurrentUserEvents(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)

	events, err := ec.eventservice.GetEventsByUser(currentUser.ID)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}
	return c.Status(fiber.StatusOK).JSON(events)
}

// GetEventsCreatedByCurrentUser retrieves events created by the current user
// @Summary Get events created by the current user
// @Description Get a list of events created by the current user
// @Tags Events
// @Accept json
// @Produce json
// @Success 200 {array} dtos.EventDTO "List of Created Events"
// @Failure 400 {object} map[string]string "Bad Request"
// @Router /events/created-by/current [get]
func (ec *EventController) GetEventsCreatedByCurrentUser(c *fiber.Ctx) error {
	currentUser := c.Locals("user").(*ent.User)

	events, err := ec.eventservice.GetEventsCreatedByUser(currentUser.ID)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": err.Error()})
	}
	return c.Status(fiber.StatusOK).JSON(events)
}

// GetEventWithDetails retrieves an event with its detailed information
// @Summary Get event with details
// @Description Get event details by ID including additional information
// @Tags Events
// @Accept json
// @Produce json
// @Param id path string true "Event ID"
// @Success 200 {object} dtos.EventDTO "Event Details"
// @Failure 400 {object} map[string]string "Bad Request"
// @Failure 404 {object} map[string]string "Event Not Found"
// @Router /events/{id}/details [get]
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

// GetPendingParticipant retrieves the pending participants of an event
// @Summary Get pending participants for an event
// @Description Get a list of participants who are pending approval for an event
// @Tags Events
// @Accept json
// @Produce json
// @Param eventID path string true "Event ID"
// @Success 200 {array} dtos.UserDTO "List of Pending Participants"
// @Failure 400 {object} map[string]string "Bad Request"
// @Failure 403 {object} map[string]string "Forbidden"
// @Router /events/{eventID}/participants/pending [get]
func (ec *EventController) GetPendingParticipant(c *fiber.Ctx) error {

	eventID, err := ulid.Parse(c.Params("eventID"))
	user := c.Locals("user").(*ent.User)

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error": "Invalid event ID",
		})
	}

	event, err := ec.eventservice.GetEvent(eventID.String())

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	if !guards.CanAuthorize(user, event) {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{
			"error": "Unauthorized",
		})
	}

	pendingParticipants, err := ec.eventservice.GetParticipantPending(eventID.String())

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	return c.Status(fiber.StatusOK).JSON(pendingParticipants)

}

// JoinEventByCode allows a user to join an event by entering a code
// @Summary Join an event by code
// @Description Allows a user to join an event by using the provided join code
// @Tags Events
// @Accept json
// @Produce json
// @Param code path string true "Join Code"
// @Success 200 {object} map[string]string "Successfully Joined Event"
// @Failure 400 {object} map[string]string "Bad Request"
// @Router /events/join/{code} [get]
func (ec *EventController) JoinEventByCode(c *fiber.Ctx) error {

	code := c.Params("code")

	user := c.Locals("user").(*ent.User)

	event, err := ec.eventservice.JoinEventByCode(code, user.ID)

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"message": "Successfully joined event",
		"event":   event,
	})
}

// GetEventCode retrieves the event code for an event
// @Summary Get event code
// @Description Retrieves the event code required to join the event
// @Tags Events
// @Accept json
// @Produce json
// @Param eventId path string true "Event ID"
// @Success 200 {object} map[string]string "Event Code"
// @Failure 400 {object} map[string]string "Bad Request"
// @Failure 403 {object} map[string]string "Forbidden"
// @Router /events/code/{eventId} [get]
func (ec *EventController) GetEventCode(c *fiber.Ctx) error {
	eventID := c.Params("eventId")

	currentUser := c.Locals("user").(*ent.User)

	event, err := ec.eventservice.GetEventCode(eventID)

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	if !guards.CanAuthorize(currentUser, event) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"code": event.Code,
	})
}

// UpdateEventSubjects updates the subjects of an event
// @Summary Update event subjects
// @Description Update the list of subjects associated with the event
// @Tags Events
// @Accept json
// @Produce json
// @Param id path string true "Event ID"
// @Param subjects body []string true "List of Subjects"
// @Success 200 {object} map[string]string "Subjects Updated Successfully"
// @Failure 400 {object} map[string]string "Bad Request"
// @Failure 403 {object} map[string]string "Forbidden"
// @Failure 500 {object} map[string]string "Internal Server Error"
// @Router /events/subjects/update/{id} [put]
func (ec *EventController) UpdateEventSubjects(c *fiber.Ctx) error {
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

	var subjects []string
	if err := c.BodyParser(&subjects); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}
	ctx := context.WithValue(c.Context(), "user_id", currentUser.ID)
	err := ec.eventservice.UpdateEventSubjects(ctx, event.ID, subjects)

	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}
	return c.JSON(fiber.Map{"message": "Subjects updated successfully"})
}

func (ec *EventController) UpdateEventAdmin(c *fiber.Ctx) error {
	eventID, errParse := ulid.Parse(c.Params("id"))
	if errParse != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid ID"})
	}

	currentUser := c.Locals("user").(*ent.User)

	_, errGetEvent := ec.eventservice.GetEvent(eventID.String())

	if errGetEvent != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": errGetEvent.Error()})
	}

	if !guards.IsAdmin(currentUser) {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Not authorized"})
	}

	var eventDTO dtos.UpdateEventAdminDTO
	if err := c.BodyParser(&eventDTO); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	ctx := context.WithValue(c.Context(), "user_id", currentUser.ID)
	err := ec.eventservice.UpdateEventAdmin(ctx, eventID.String(), eventDTO)

	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": err.Error()})
	}
	return c.JSON(fiber.Map{"message": "Event updated successfully"})
}
