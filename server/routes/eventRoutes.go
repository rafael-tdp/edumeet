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
	app.Get("/events", middlewares.JWTAuthMiddleware, eventController.GetAllEvents)
	app.Get("/events/users/current", middlewares.JWTAuthMiddleware, eventController.GetCurrentUserEvents)
	app.Get("/events/created-by/current", middlewares.JWTAuthMiddleware, eventController.GetEventsCreatedByCurrentUser)
	app.Get("/events/:id", middlewares.JWTAuthMiddleware, eventController.GetEvent)
	app.Get("/events/:id/details", middlewares.JWTAuthMiddleware, eventController.GetEventWithDetails)
	app.Post("/events", middlewares.JWTAuthMiddleware, eventController.CreateEvent)
	app.Put("/events/:id", middlewares.JWTAuthMiddleware, eventController.UpdateEvent)
	app.Delete("/events/:id", middlewares.JWTAuthMiddleware, eventController.DeleteEvent)
	app.Get("/events/:eventID/participants/pending", middlewares.JWTAuthMiddleware, eventController.GetPendingParticipant)
	app.Get("/events/join/:code", middlewares.JWTAuthMiddleware, eventController.JoinEventByCode)
	app.Get("/events/code/:eventId", middlewares.JWTAuthMiddleware, eventController.GetEventCode)
	app.Put("/events/subjects/update/:id", middlewares.JWTAuthMiddleware, eventController.UpdateEventSubjects)
}

func initEventController(client *ent.Client) *controllers.EventController {
	eventRepository := repositories.NewEventRepository(client)
	participantRepository := repositories.NewParticipantRepository(client)
	eventService := services.NewEventService(eventRepository, participantRepository)
	emailService := services.NewEmailService()
	return controllers.NewEventController(eventService, emailService)
}
