package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/repositories"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupRoutesSubject(app *fiber.App, subjectController *controllers.SubjectController) {

	app.Post("/subjects", subjectController.Create)
	app.Delete("/subjects/:id", subjectController.Delete)
	app.Put("/subjects/:id", subjectController.Update)
	app.Get("/subjects", subjectController.GetSubjects)
}

func initSubjectController(client *ent.Client) *controllers.SubjectController {

	subjectRepository := repositories.NewSubjectRepository(client)
	subjectService := services.NewSubjectService(subjectRepository)
	emailService := services.NewEmailService()
	return controllers.NewSubjectController(subjectService, emailService)
}
