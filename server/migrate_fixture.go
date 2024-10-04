package main

import (
	"context"
	"edumeet/ent"
	"edumeet/fixture"
	"log"
	"os"

	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
)

func migrateFixture() {
	err := godotenv.Load()
	if err != nil {
		log.Fatalf("Error loading .env file")
	}

	client, err := ent.Open("postgres", os.Getenv("DATABASE_URL"))
	if err != nil {
		log.Fatalf("failed opening connection to PostgreSQL: %v", err)
	}
	defer client.Close()

	ctx := context.Background()
	// delete all data
	client.User.Delete().ExecX(ctx)
	userFixture := fixture.User{}
	userFixture.GenerateFixture(ctx, client)

	log.Println("Fixtures applied successfully.")
}
