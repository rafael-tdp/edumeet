package main

import (
	"edumeet/routes"
	"edumeet/utils"
	"flag"
	"fmt"
	"log"
	"net/http"
	"sync"

	"github.com/gofiber/fiber/v2/middleware/cors"
	"github.com/joho/godotenv"

	_ "edumeet/ent/runtime"

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
		drop()
		migrate()
	} else if *mode == "fixture" {
		migrateFixture()
	} else {
		err := godotenv.Load()
		if err != nil {
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

		http.HandleFunc("/ws", utils.HandleConnection)

		var wg sync.WaitGroup
		wg.Add(2)

		go func() {
			defer wg.Done()
			if err := app.Listen(":3000"); err != nil {
				log.Fatal(err)
			}
		}()

		go func() {
			defer wg.Done()
			if err := http.ListenAndServe(":8081", nil); err != nil {
				log.Fatal(err)
			}
		}()
		wg.Wait()
	}
}
