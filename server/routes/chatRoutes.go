package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/middlewares"
	"edumeet/repositories"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupRoutesChat(app *fiber.App, chatController *controllers.ChatController) {
	app.Get("/events/:event_id/messages", middlewares.JWTAuthMiddleware, chatController.GetChats)
	app.Get("/events/:event_id/connect", middlewares.JWTAuthMiddleware, chatController.ConnectToEvent)
	app.Post("/events/:event_id/messages", middlewares.JWTAuthMiddleware, chatController.SendMessage)
	app.Delete("/events/:event_id/messages/:message_id", middlewares.JWTAuthMiddleware, chatController.DeleteMessage)
}

func initChatController(client *ent.Client) *controllers.ChatController {
	chatRepo := repositories.NewChatRepository(client)
	chatService := services.NewChatService(chatRepo)

	eventRepository := repositories.NewEventRepository(client)
	participantRepository := repositories.NewParticipantRepository(client)
	eventService := services.NewEventService(eventRepository, participantRepository)

	return controllers.NewChatController(chatService, eventService)
}
