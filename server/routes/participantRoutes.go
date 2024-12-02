package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/middlewares"
	"edumeet/repositories"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupRoutesParticipant(app *fiber.App, participantController *controllers.ParticipantController) {
	app.Get("/participant/request/:eventID", middlewares.JWTAuthMiddleware, participantController.RequestParticipant)
	app.Get("/participant/process/:participantID/:status", middlewares.JWTAuthMiddleware, participantController.ProcessParticipant)
}

func initParticipantController(client *ent.Client) *controllers.ParticipantController {

	participantRepository := repositories.NewParticipantRepository(client)
	eventRepository := repositories.NewEventRepository(client)
	participantService := services.NewParticipantService(participantRepository, eventRepository)
	emailService := services.NewEmailService()
	return controllers.NewParticipantController(participantService, emailService)
}
