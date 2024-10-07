package routes

import (
	"github.com/gofiber/fiber/v2"
)

func InitRoutes(app *fiber.App) {
	//Initialiser les routes user
	userController := initUserController()
	setupRoutesUser(app, userController)
}
