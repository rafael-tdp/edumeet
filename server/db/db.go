package db

import (
	"edumeet/ent"
	"log"
	"os"

	"github.com/joho/godotenv"
)

func OpenDBConnection() (*ent.Client, error) {

	err := godotenv.Load()
	if err != nil {
		log.Printf("Error loading .env file: %v", err)
	}

	dbURL := os.Getenv("DATABASE_URL")
	if dbURL == "" {
		log.Fatalf("DATABASE_URL is not set in the environment")
	}

	client, err := ent.Open("postgres", dbURL)
	if err != nil {
		log.Fatalf("failed opening connection to PostgreSQL: %v", err)
		return nil, err
	}

	return client, nil
}
