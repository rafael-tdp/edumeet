package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/middlewares"
	"edumeet/repositories"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupRoutesReporting(app *fiber.App, reportingController *controllers.ReportingController) {

	//app.Get("/reporting/:id", middlewares.JWTAuthMiddleware, reportingController.GetReporting)
	//app.Post("/reporting", middlewares.JWTAuthMiddleware, reportingController.CreateReporting)
	app.Delete("/reporting/:id", middlewares.JWTAuthMiddleware, reportingController.DeleteReporting)
}

func initReportingController(client *ent.Client) *controllers.ReportingController {

	reportingRepo := repositories.NewReportingRepository(client)
	reportingService := services.NewReportingService(reportingRepo)
	return controllers.NewReportingController(reportingService)
}
