package db

import (
	"edumeet/ent"
	"log"
	"os"
	"sync"
)

var (
	clientInstance *ent.Client
	once           sync.Once
)

func OpenDBConnection() (*ent.Client, error) {
	var err error

	once.Do(func() {
		dbURL := os.Getenv("DATABASE_URL")
		if dbURL == "" {
			log.Fatalf("DATABASE_URL is not set in the environment")
		}

		clientInstance, err = ent.Open("postgres", dbURL)
		if err != nil {
			log.Fatalf("Failed opening connection to PostgreSQL: %v", err)
		}
	})

	return clientInstance, err
}
