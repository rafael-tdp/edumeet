package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/repositories"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupEventRoutes(app *fiber.App, eventController *controllers.EventController) {
	app.Post("/api/event/remote", eventController.CreateRemoteEvent)
	app.Delete("/api/event/:id", eventController.DeleteEvent)
}

func initEventController(client *ent.Client) *controllers.EventController {
	eventRepository := repositories.NewEventRepository(client)
	eventService := services.NewEventService(eventRepository)
	emailService := services.NewEmailService()
	return controllers.NewEventController(eventService, emailService)

}
