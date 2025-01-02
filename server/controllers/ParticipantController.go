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

// @Summary Request to join an event as a participant
// @Description Request to participate in an event using the event ID
// @Tags Participant
// @Accept json
// @Produce json
// @Param eventID path string true "Event ID"
// @Success 200 {object} map[string]string "Success: Requested participation"
// @Failure 400 {object} map[string]string "Bad Request: Invalid event ID"
// @Security JWT
// @Router /participants/request/{eventID} [get]
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

// @Summary Process participant status
// @Description Change the status of a participant in an event
// @Tags Participant
// @Accept json
// @Produce json
// @Param participantID path string true "Participant ID"
// @Param status path string true "Status to be applied (e.g. accepted, rejected)"
// @Success 200 {object} map[string]string "Success: Participant status processed"
// @Failure 400 {object} map[string]string "Bad Request: Invalid participant ID"
// @Failure 401 {object} map[string]string "Unauthorized: User not allowed to process this participant"
// @Security JWT
// @Router /participants/process/{participantID}/{status} [get]
func (pc *ParticipantController) ProcessParticipant(c *fiber.Ctx) error {

	statut := c.Params("status")
	participantID := c.Params("participantID")

	user := c.Locals("user").(*ent.User)

	participantDetail, err := pc.participantService.GetParticipantDetail(participantID)

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error": "Invalid participant ID",
		})
	}

	if *participantDetail.Event.CreatedBy != user.ID && user.Role != "admin" {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{
			"error": "Unauthorized",
		})
	}

	return pc.participantService.ProcessParticipant(*participantDetail, statut)
}

// @Summary Leave an event participation
// @Description Remove a participant from an event
// @Tags Participant
// @Accept json
// @Produce json
// @Param participantID path string true "Participant ID"
// @Success 200 {object} map[string]string "Success: Left the event"
// @Failure 400 {object} map[string]string "Bad Request: Invalid participant ID"
// @Failure 401 {object} map[string]string "Unauthorized: User not authorized to leave this event"
// @Security JWT
// @Router /participants/{participantID} [delete]
func (pc *ParticipantController) LeaveEventParticipation(c *fiber.Ctx) error {

	participantID := c.Params("participantID")

	user := c.Locals("user").(*ent.User)
	participantDetail, err := pc.participantService.GetParticipantDetail(participantID)

	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error": "Invalid participant ID",
		})
	}

	isValidUser := (*participantDetail.Event.CreatedBy == user.ID || user.Role == "admin") || participantDetail.User.ID == user.ID

	if !isValidUser {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{
			"error": "Unauthorized",
		})
	}

	pc.participantService.LeaveEventParticipation(participantID)

	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"message": "Successfully left the event",
	})

}
