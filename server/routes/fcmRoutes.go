package routes

import (
	"edumeet/controllers"
	"edumeet/middlewares"

	"github.com/gofiber/fiber/v2"
)

func setupRoutesFcm(app *fiber.App, fcmController *controllers.FcmController) {

	app.Post("/store-fcm-token/:token", middlewares.JWTAuthMiddleware, fcmController.StoreFcmToken)
}

func initFcmController() *controllers.FcmController {
	return controllers.NewFcmController()
}
