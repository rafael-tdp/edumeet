package routes

import (
	_ "edumeet/docs"

	"github.com/gofiber/fiber/v2"
	fiberSwagger "github.com/swaggo/fiber-swagger"
)

func setupRoutesSwagger(app *fiber.App) {
	app.Get("/swagger/*", fiberSwagger.WrapHandler)
}
