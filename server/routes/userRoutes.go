package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/repositories"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupRoutesUser(app *fiber.App, userController *controllers.UserController) {

	app.Get("/user/:id", userController.GetUser)
	app.Post("user/register", userController.Register)
	app.Get("user/verify-email/:code", userController.ValidateUser)
	app.Get("user/resend-verify-email/:email", userController.ResendEmailValidateUser)
	app.Post("login", userController.Login)
}

func initUserController(client *ent.Client) *controllers.UserController {

	userRepo := repositories.NewUserRepository(client)
	userService := services.NewUserService(userRepo)
	emailService := services.NewEmailService()
	return controllers.NewUserController(userService, emailService)
}
