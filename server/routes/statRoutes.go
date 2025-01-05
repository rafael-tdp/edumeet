package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/middlewares"
	"edumeet/repositories"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupRoutesStat(app *fiber.App, statController *controllers.StatController) {
	app.Get("/stats", middlewares.JWTAuthMiddleware, statController.GetStats)
}

func initStatController(client *ent.Client) *controllers.StatController {

	subjectRepository := repositories.NewSubjectRepository(client)
	userRepository := repositories.NewUserRepository(client)
	eventRepository := repositories.NewEventRepository(client)
	statService := services.NewStatService(subjectRepository, userRepository, eventRepository)
	return controllers.NewStatController(statService)
}
