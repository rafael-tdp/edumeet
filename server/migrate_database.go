package main

import (
	"context"
	"database/sql"
	"edumeet/ent"
	"fmt"
	"log"
	"os"
	"strings"

	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
	"github.com/sirupsen/logrus"
)

func migrate() {
	err := godotenv.Load()
	if err != nil {
		logrus.Error("Error loading .env file: %v", err)
		log.Fatalf("Error loading .env file")
	}

	client, err := ent.Open("postgres", os.Getenv("DATABASE_URL"))
	if err != nil {
		logrus.Error("failed opening connection to PostgreSQL: %v", err)
		log.Fatalf("failed opening connection to PostgreSQL: %v", err)
	}
	defer client.Close()

	ctx := context.Background()
	if err := client.Schema.Create(ctx); err != nil {
		log.Fatalf("failed creating schema resources: %v", err)
	}
	logrus.Info("Migrations applied successfully.")
	log.Println("Migrations applied successfully.")
}

func drop() {
	err := godotenv.Load()
	if err != nil {
		logrus.Error("Erreur lors du chargement du fichier .env : %v", err)
		log.Fatalf("Erreur lors du chargement du fichier .env : %v", err)
	}

	dsn := os.Getenv("DATABASE_URL")
	dbname := strings.Split(strings.Split(dsn, "/")[3], "?")[0]
	connStr := strings.Replace(dsn, dbname, "postgres", 1)
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		logrus.Error("Erreur lors de la connexion à PostgreSQL : %v", err)
		log.Fatalf("Erreur lors de la connexion à PostgreSQL : %v", err)
	}
	defer db.Close()

	_, err = db.ExecContext(context.Background(), "DROP DATABASE "+dbname)
	if err != nil {
		logrus.Error("Erreur lors de la suppression de la base de données : %v", err)
		log.Fatalf("Erreur lors de la suppression de la base de données : %v", err)
	}
	logrus.Info("Base de données supprimée avec succès !")
	fmt.Println("Base de données supprimée avec succès !")

	db.ExecContext(context.Background(), "CREATE DATABASE "+dbname)
	if err != nil {
		logrus.Error("Erreur lors de la création de la base de données : %v", err)
		log.Fatalf("Erreur lors de la création de la base de données : %v", err)
	}
	logrus.Info("Base de données créée avec succès !")
	fmt.Println("Base de données créée avec succès !")

	db.Close()
}
