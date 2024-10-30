package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/middlewares"
	"edumeet/repositories"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupRoutesBadge(app *fiber.App, badgeController *controllers.BadgeController) {

	app.Get("/badge/:id", badgeController.GetBadge)
	app.Get("/badge", badgeController.GetBadges)
	app.Post("/badge", middlewares.JWTAuthMiddleware, badgeController.CreateBadge)
	app.Delete("/badge/:id", middlewares.JWTAuthMiddleware, badgeController.DeleteBadge)
	app.Put("/badge/:id", middlewares.JWTAuthMiddleware, badgeController.UpdateBadge)
}

func initBadgeController(client *ent.Client) *controllers.BadgeController {

	badgeRepo := repositories.NewBadgeRepository(client)
	badgeService := services.NewBadgeService(badgeRepo)
	return controllers.NewBadgeController(badgeService)
}
