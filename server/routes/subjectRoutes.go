package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/middlewares"
	"edumeet/repositories"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupRoutesSubject(app *fiber.App, subjectController *controllers.SubjectController) {

	app.Post("/subjects", middlewares.JWTAuthMiddleware, subjectController.Create)
	app.Delete("/subjects/:id", middlewares.JWTAuthMiddleware, subjectController.Delete)
	app.Put("/subjects/:id", middlewares.JWTAuthMiddleware, subjectController.Update)
	app.Get("/subjects", subjectController.GetSubjects)
}

func initSubjectController(client *ent.Client) *controllers.SubjectController {

	subjectRepository := repositories.NewSubjectRepository(client)
	subjectService := services.NewSubjectService(subjectRepository)
	emailService := services.NewEmailService()
	return controllers.NewSubjectController(subjectService, emailService)
}
