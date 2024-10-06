package main

import (
	"edumeet/controllers"
	"edumeet/db"
	"edumeet/repositories"
	"edumeet/services"
	"flag"
	"fmt"
	"log"

	"github.com/brianvoe/gofakeit/v7"
	"github.com/gofiber/fiber/v2"
	"github.com/oklog/ulid/v2"
)

func main() {
	// Utilisation de flag pour choisir le mode (normal, fixture ou migrate)
	mode := flag.String("mode", "normal", "Choose the mode: normal, fixture or migrate")
	flag.Parse()

	// Vérifier le mode sélectionné et appeler les fonctions appropriées
	if *mode == "migrate" {
		migrate()
	} else if *mode == "fixture" {
		migrateFixture()
	} else {
		// Initialiser une nouvelle application Fiber
		app := fiber.New()

		// Définir une route GET pour l'URL racine '/'
		app.Get("/", func(c *fiber.Ctx) error {
			// Générer un ULID et un email aléatoire, et les retourner dans la réponse
			fmt.Println(ulid.Make())
			return c.SendString("Hello, World! " + gofakeit.Email())
		})

		app.Post("/login", repositories.LoginHandler)

		userController := initUserController()

		// Configurer les routes
		setupRoutes(app, userController)

		// Démarrer le serveur sur le port 3000
		log.Fatal(app.Listen(":3000"))
	}
}

func setupRoutes(app *fiber.App, userController *controllers.UserController) {

	app.Get("/user/:id", userController.GetUser)
}

func initUserController() *controllers.UserController {

	client, err := db.OpenDBConnection()
	if err != nil {
		log.Fatalf("Could not open database connection: %v", err)
	}

	userRepo := repositories.NewUserRepository(client)
	userService := services.NewUserService(userRepo)
	return controllers.NewUserController(userService)
}
