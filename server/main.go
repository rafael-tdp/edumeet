package main

import (
	"flag"
	"fmt"
	"log"

	"github.com/brianvoe/gofakeit/v7"
	"github.com/gofiber/fiber/v3"
	"github.com/oklog/ulid/v2"
)

func main() {
	mode := flag.String("mode", "normal", "Choose the mode: normal, fixture or migrate")
	flag.Parse()
	if *mode == "migrate" {
		migrate()
	} else if *mode == "fixture" {
		//fixture()
	} else {
		// Initialize a new Fiber app
		app := fiber.New()
		//name := lo.Uniq([]string{"Samuel", "John", "Samuel"})
		// Define a route for the GET method on the root path '/'
		app.Get("/", func(c fiber.Ctx) error {
			// Send a string response to the client
			fmt.Println(ulid.Make())
			return c.SendString("Hello, World !" + gofakeit.Email())
		})

		// Start the server on port 3000
		log.Fatal(app.Listen(":3000"))
	}
}
