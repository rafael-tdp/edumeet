package main

import (
	"flag"
	"fmt"
	"log"

	"github.com/gofiber/fiber/v2/middleware/cors"
	"github.com/joho/godotenv"
	"github.com/sirupsen/logrus"
	"gopkg.in/natefinch/lumberjack.v2"

	_ "edumeet/ent/runtime"
	"edumeet/routes"
	"edumeet/utils"

	"github.com/brianvoe/gofakeit/v7"
	"github.com/gofiber/fiber/v2"
	"github.com/oklog/ulid/v2"
)

// @title EduMeet API Documentation
// @version 1.0
// @description This is the API documentation for the EduMeet project.
// @termsOfService http://swagger.io/terms/

// @contact.name API Support
// @contact.url http://www.swagger.io/support
// @contact.email support@swagger.io

// @license.name Apache 2.0
// @license.url http://www.apache.org/licenses/LICENSE-2.0.html

// @host localhost:3000
// @BasePath /
func main() {

	// Initialiser le logger
	initLogger()
	// Utilisation de flag pour choisir le mode (normal, fixture ou migrate)
	mode := flag.String("mode", "normal", "Choose the mode: normal, fixture or migrate")
	flag.Parse()
	logrus.Info(("Application started in mode: " + *mode))
	// Vérifier le mode sélectionné et appeler les fonctions appropriées
	if *mode == "migrate" {
		drop()
		migrate()
	} else if *mode == "fixture" {
		migrateFixture()
	} else {
		err := godotenv.Load()
		if err != nil {
			logrus.Error("Error loading .env file: %v", err)
			log.Printf("Error loading .env file: %v", err)
		}

		// Initialiser une nouvelle application Fiber
		app := fiber.New(fiber.Config{
			BodyLimit: 25 * 1024 * 1024,
		})

		app.Use(cors.New())

		app.Get("/", func(c *fiber.Ctx) error {
			// Générer un ULID et un email aléatoire, et les retourner dans la réponse
			fmt.Println(ulid.Make())
			return c.SendString("Hello, World! " + gofakeit.Email())
		})

		utils.InitRedis()

		routes.InitRoutes(app)

		app.Listen(":3000")

	}
}

func initLogger() {
	logrus.SetFormatter(&logrus.JSONFormatter{})
	logrus.SetOutput(&lumberjack.Logger{
		Filename:   "logs/app.log",
		MaxSize:    10, // megabytes
		MaxBackups: 3,
		MaxAge:     28,   //days
		Compress:   true, // disabled by default
	})
	logrus.SetLevel(logrus.InfoLevel)
}
