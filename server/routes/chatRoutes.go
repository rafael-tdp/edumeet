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
	app.Get("/chats/conversations", middlewares.JWTAuthMiddleware, chatController.GetConversations)
	app.Get("/chats/connect", middlewares.JWTAuthMiddleware, chatController.Connect)
	app.Post("/chats/send-message-to-event/:eventId", middlewares.JWTAuthMiddleware, chatController.SendMessageToEvent)
	app.Delete("/chats/delete-message-to-event/:eventId/:messageId", middlewares.JWTAuthMiddleware, chatController.DeleteMessageEvent)
	app.Post("/chats/send-message-to-friend/:friendId", middlewares.JWTAuthMiddleware, chatController.SendMessageToFriend)
	app.Delete("/chats/delete-message-to-friend/:friendId/:messageId", middlewares.JWTAuthMiddleware, chatController.DeleteMessageFriend)
}

func initChatController(client *ent.Client) *controllers.ChatController {
	chatRepo := repositories.NewChatRepository(client)
	userRepository := repositories.NewUserRepository(client)
	participantRepository := repositories.NewParticipantRepository(client)
	chatService := services.NewChatService(chatRepo, userRepository, participantRepository)
	eventRepository := repositories.NewEventRepository(client)
	eventService := services.NewEventService(eventRepository, participantRepository)

	return controllers.NewChatController(chatService, eventService)
}
