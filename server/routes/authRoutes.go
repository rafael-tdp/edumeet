package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/repositories"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupRoutesAuth(app *fiber.App, authController *controllers.AuthController, userController *controllers.UserController) {
	app.Post("/login", authController.Login)
	app.Post("/register", authController.Register)
	app.Post("/forgot-password", authController.ForgotPassword)
	app.Post("/reset-password", authController.ResetPassword)
	app.Get("/resend-verify-email/:email", userController.ResendEmailValidateUser)
	app.Get("/auth/google/login", authController.GoogleLogin)
	app.Get("/auth/google/callback", authController.GoogleCallback)
}

func initAuthController(client *ent.Client) *controllers.AuthController {
	userRepo := repositories.NewUserRepository(client)
	authService := services.NewAuthService(userRepo)
	emailService := services.NewEmailService()
	oauthService := services.NewOAuthService()
	return controllers.NewAuthController(authService, emailService, oauthService)
}
