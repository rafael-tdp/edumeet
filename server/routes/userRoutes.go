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

	app.Get("/user/:id", middlewares.JWTAuthMiddleware, userController.GetUser)
	app.Post("/user/register", userController.Register)
	app.Post("/user/validate-user", userController.ValidateUser)
	app.Post("/user/verify", userController.Verify)
	app.Get("/user/resend-verify-email/:email", userController.ResendEmailValidateUser)
	app.Post("/login", userController.Login)
	app.Get("/me", middlewares.JWTAuthMiddleware, userController.Me)
	app.Post("/user/forgot-password", userController.ForgotPassword)
	app.Post("/user/reset-password", userController.ResetPassword)

}

func initUserController(client *ent.Client) *controllers.UserController {

	userRepo := repositories.NewUserRepository(client)
	userService := services.NewUserService(userRepo)
	emailService := services.NewEmailService()
	return controllers.NewUserController(userService, emailService)
}
