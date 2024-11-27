package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/middlewares"
	"edumeet/repositories"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupRoutesAI(app *fiber.App, aiController *controllers.AIController) {

	app.Post("/ai/generate-exo/:id", middlewares.JWTAuthMiddleware, aiController.GenerateExo)
	app.Post("/ai/generate-correction/:id", middlewares.JWTAuthMiddleware, aiController.GenerateCorrection)
}

func initAIController(client *ent.Client) *controllers.AIController {

	aiService := services.NewAIService()
	eventService := services.NewEventService(repositories.NewEventRepository(client), nil)
	return controllers.NewAIController(aiService, eventService)
}
