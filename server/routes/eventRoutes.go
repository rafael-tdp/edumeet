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
	app.Post("/api/event/remote", middlewares.JWTAuthMiddleware, eventController.CreateRemoteEvent)
	app.Delete("/api/event/:id", eventController.DeleteEvent)
	app.Get("/api/event/remote/:id", eventController.GetRemoteEvent)
	app.Put("/api/event/remote/:id", eventController.UpdateRemoteEvent)
	app.Get("/api/event/:id", eventController.GetEvent)
	app.Get("/api/events", eventController.GetAllEvents)
	app.Get("/api/events/user/current", middlewares.JWTAuthMiddleware, eventController.GetCurrentUserEvents)
}

func initEventController(client *ent.Client) *controllers.EventController {
	eventRepository := repositories.NewEventRepository(client)
	participantRepository := repositories.NewParticipantRepository(client)
	eventService := services.NewEventService(eventRepository, participantRepository)
	emailService := services.NewEmailService()
	return controllers.NewEventController(eventService, emailService)
}
