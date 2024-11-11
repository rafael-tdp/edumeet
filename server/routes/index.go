package routes

import (
	"edumeet/db"
	"log"

	"github.com/gofiber/fiber/v2"
)

func InitRoutes(app *fiber.App) {
	// On ouvre une seule connexion à la base de données et on donne l'instance de la connexion à chaque contrôleur
	client, err := db.OpenDBConnection()
	if err != nil {
		log.Fatalf("Could not open database connection: %v", err)
	}

	//Initialiser les routes user
	userController := initUserController(client)
	setupRoutesUser(app, userController)

	//Initialiser les routes reporting
	reportingController := initReportingController(client)
	setupRoutesReporting(app, reportingController)

	//Initialiser les routes badge
	badgeController := initBadgeController(client)
	setupRoutesBadge(app, badgeController)
	//Initialiser les routes subject
	subjectController := initSubjectController(client)
	setupRoutesSubject(app, subjectController)
	//Initialiser les routes event
	eventController := initEventController(client)
	setupEventRoutes(app, eventController)
}
