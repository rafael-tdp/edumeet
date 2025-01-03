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

	//Initialiser les routes auth
	authController := initAuthController(client)
	setupRoutesAuth(app, authController, userController)

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

	//Initialiser les routes participant
	participantController := initParticipantController(client)
	setupRoutesParticipant(app, participantController)

	//Initialiser les routes document
	documentController := initDocumentController(client)
	setupRoutesDocument(app, documentController)

	//Initialiser les routes chat
	chatController := initChatController(client)
	setupRoutesChat(app, chatController)
	//Initialiser les routes ai
	aiController := initAIController(client)
	setupRoutesAI(app, aiController)

	//Initialiser les routes address
	addressController := initAddressController(client)
	setupRoutesAddress(app, addressController)

	//Initialiser les routes fcm
	fcmController := initFcmController()
	setupRoutesFcm(app, fcmController)

	//Initialiser les routes swagger
	setupRoutesSwagger(app)
}
