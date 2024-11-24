package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/repositories"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupRoutesChat(app *fiber.App, badgeController *controllers.ChatController) {
}

func initChatController(client *ent.Client) *controllers.ChatController {
	chatRepo := repositories.NewChatRepository(client)
	chatService := services.NewChatService(chatRepo)
	return controllers.NewChatController(chatService)
}
