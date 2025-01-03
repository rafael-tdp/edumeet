package firebase

import (
	"context"
	"fmt"
	"sync"

	firebase "firebase.google.com/go"
	"firebase.google.com/go/messaging"
	"google.golang.org/api/option"
)

// Déclarez une variable globale pour le singleton
var (
	app       *firebase.App
	fcmClient *messaging.Client
	once      sync.Once
)

// initializeFirebase initialise Firebase une seule fois et récupère le client FCM
func initializeFirebase() (*firebase.App, *messaging.Client, error) {
	once.Do(func() {
		// Définissez le chemin vers votre fichier credentials.json
		credentialsFile := "credentials.json" // Remplacez par le chemin réel de votre fichier

		// Initialisation de Firebase avec le fichier credentials.json
		var err error
		app, err = firebase.NewApp(context.Background(), nil, option.WithCredentialsFile(credentialsFile))
		if err != nil {
			fmt.Errorf("Error initializing Firebase app: %v", err)
			return
		}

		// Initialisation du client FCM
		fcmClient, err = app.Messaging(context.Background())
		if err != nil {
			fmt.Errorf("Error initializing FCM client: %v", err)
			return
		}
	})

	if app == nil || fcmClient == nil {
		return nil, nil, fmt.Errorf("Firebase or FCM client not initialized")
	}
	return app, fcmClient, nil
}

// SendNotification envoie une notification à un token spécifique
func SendNotification(token, title, body string) error {
	// Initialisez Firebase et FCM uniquement une fois
	_, fcmClient, err := initializeFirebase()
	if err != nil {
		return fmt.Errorf("Error initializing Firebase or FCM client: %v", err)
	}

	// Créez le message de notification
	message := &messaging.Message{
		Notification: &messaging.Notification{
			Title: title,
			Body:  body,
		},
		Token: token,
	}

	// Envoi de la notification
	_, err = fcmClient.Send(context.Background(), message)
	if err != nil {
		return fmt.Errorf("Error sending notification: %v", err)
	}

	return nil
}
