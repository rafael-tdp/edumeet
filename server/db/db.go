package db

import (
	"edumeet/ent"
	"log"
	"os"
	"sync"

	"github.com/joho/godotenv"
)

var (
	clientInstance *ent.Client
	once           sync.Once
)

// OpenDBConnection returns the singleton instance of the DB connection
func OpenDBConnection() (*ent.Client, error) {
	var err error

	// Use sync.Once to ensure the database connection is created only once
	once.Do(func() {
		err := godotenv.Load()
		if err != nil {
			log.Printf("Error loading .env file: %v", err)
		}

		dbURL := os.Getenv("DATABASE_URL")
		if dbURL == "" {
			log.Fatalf("DATABASE_URL is not set in the environment")
		}

		// Open a connection to PostgreSQL
		clientInstance, err = ent.Open("postgres", dbURL)
		if err != nil {
			log.Fatalf("Failed opening connection to PostgreSQL: %v", err)
		}
	})

	// Return the client instance and any error encountered
	return clientInstance, err
}
