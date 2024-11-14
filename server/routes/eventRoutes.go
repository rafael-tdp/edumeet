package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/middlewares"
	"edumeet/repositories"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupEventRoutes(app *fiber.App, eventController *controllers.EventController) {
	app.Get("/api/events", eventController.GetAllEvents)
	app.Get("/api/events/:id", eventController.GetEvent)
	app.Post("/api/events", middlewares.JWTAuthMiddleware, eventController.CreateEvent)
	app.Put("/api/events/:id", eventController.UpdateEvent)
	app.Delete("/api/events/:id", eventController.DeleteEvent)
}

func initEventController(client *ent.Client) *controllers.EventController {
	eventRepository := repositories.NewEventRepository(client)
	participantRepository := repositories.NewParticipantRepository(client)
	eventService := services.NewEventService(eventRepository, participantRepository)
	emailService := services.NewEmailService()
	return controllers.NewEventController(eventService, emailService)

}
