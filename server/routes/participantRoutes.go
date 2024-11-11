package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/repositories"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupRoutesParticipant(app *fiber.App, subjectController *controllers.ParticipantController) {
}

func initParticipantController(client *ent.Client) *controllers.ParticipantController {

	participantRepository := repositories.NewParticipantRepository(client)
	participantService := services.NewParticipantService(participantRepository)
	emailService := services.NewEmailService()
	return controllers.NewParticipantController(participantService, emailService)
}
