package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/repositories"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupRoutesParticipant(app *fiber.App, participantController *controllers.ParticipantController) {
	app.Post("/participant/request/:eventID", participantController.RequestParticipant)
	app.Post("/participant/accept/:participantID", participantController.AcceptParticipant)
}

func initParticipantController(client *ent.Client) *controllers.ParticipantController {

	participantRepository := repositories.NewParticipantRepository(client)
	eventRepository := repositories.NewEventRepository(client)
	participantService := services.NewParticipantService(participantRepository, eventRepository)
	emailService := services.NewEmailService()
	return controllers.NewParticipantController(participantService, emailService)
}
