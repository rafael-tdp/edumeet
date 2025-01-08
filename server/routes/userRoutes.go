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
	app.Get("/users", middlewares.AdminMiddleware, userController.GetUsers)
	app.Get("/me", middlewares.JWTAuthMiddleware, userController.Me)
	app.Post("/user/verify", userController.Verify)
	app.Post("/user/create", middlewares.JWTAuthMiddleware, userController.CreateUserAdmin)
	app.Delete("/user/:id", middlewares.JWTAuthMiddleware, userController.DeleteUser)
	app.Post("/user/validate-user", userController.ValidateUser)
	app.Get("/user/information/:id", middlewares.JWTAuthMiddleware, userController.GetUser)
	app.Put("/user/:id", middlewares.JWTAuthMiddleware, userController.UpdateUser)
	app.Get("/user/subjects", middlewares.JWTAuthMiddleware, userController.GetUserSubjects)
	app.Put("/user/subjects/update", middlewares.JWTAuthMiddleware, userController.UpdateUserSubjects)
	app.Post("/user/friendship", middlewares.JWTAuthMiddleware, userController.CreateFriendship)
	app.Put("/user/friendship/:id", middlewares.JWTAuthMiddleware, userController.AcceptFriendship)
	app.Get("/user/friendship", middlewares.JWTAuthMiddleware, userController.GetFriendships)
	app.Delete("/user/friendship/:id", middlewares.JWTAuthMiddleware, userController.DeleteFriendship)
	app.Patch("/user/admin/:id", middlewares.JWTAuthMiddleware, userController.UpdateUserAdmin)
	app.Put("/user/like/document/:id", middlewares.JWTAuthMiddleware, userController.LikeDocument)
	app.Put("/user/unlike/document/:id", middlewares.JWTAuthMiddleware, userController.UnlikeDocument)
}

func initUserController(client *ent.Client) *controllers.UserController {
	userRepo := repositories.NewUserRepository(client)
	documentRepository := repositories.NewDocumentRepository(client)
	userService := services.NewUserService(userRepo, documentRepository)
	emailService := services.NewEmailService()
	return controllers.NewUserController(userService, emailService)
}
