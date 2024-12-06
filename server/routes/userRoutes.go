package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/middlewares"
	"edumeet/repositories"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupRoutesUser(app *fiber.App, userController *controllers.UserController) {
	app.Get("/me", middlewares.JWTAuthMiddleware, userController.Me)
	app.Post("/user/verify", userController.Verify)
	app.Post("/user/validate-user", userController.ValidateUser)
	app.Get("/user/information/:id", middlewares.JWTAuthMiddleware, userController.GetUser)
	app.Put("/user/:id", middlewares.JWTAuthMiddleware, userController.UpdateUser)
	app.Get("/user/subjects", middlewares.JWTAuthMiddleware, userController.GetUserSubjects)
}

func initUserController(client *ent.Client) *controllers.UserController {
	userRepo := repositories.NewUserRepository(client)
	userService := services.NewUserService(userRepo)
	emailService := services.NewEmailService()
	return controllers.NewUserController(userService, emailService)
}
