package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/middlewares"
	"edumeet/repositories"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupRoutesDocument(app *fiber.App, documentController *controllers.DocumentController) {

	app.Get("/document/:id", middlewares.JWTAuthMiddleware, documentController.GetDocument)
	app.Post("/document", middlewares.JWTAuthMiddleware, documentController.CreateDocument)
	app.Delete("/document/:id", middlewares.JWTAuthMiddleware, documentController.DeleteDocument)
}

func initDocumentController(client *ent.Client) *controllers.DocumentController {

	documentRepo := repositories.NewDocumentRepository(client)
	documentService := services.NewDocumentService(documentRepo)
	return controllers.NewDocumentController(documentService)
}
