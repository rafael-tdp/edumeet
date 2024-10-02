package main

import (
    "context"
    "log"
    "github.com/joho/godotenv"
    _ "github.com/lib/pq"
    "os"
    "edumeet/ent"
)

func migrate() {
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
    if err := client.Schema.Create(ctx); err != nil {
        log.Fatalf("failed creating schema resources: %v", err)
    }

    log.Println("Migrations applied successfully.")
}
