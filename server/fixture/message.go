package fixture

import (
	"context"
	"edumeet/ent"

	"github.com/brianvoe/gofakeit/v7"
)

type Message struct{}

func (m *Message) GenerateMessagesForEvents(ctx context.Context, client *ent.Client) {
	// Récupérer les événements ayant des participants
	events, err := client.Event.Query().
		WithParticipants(func(q *ent.ParticipantQuery) {
			q.WithUser() // Inclure les utilisateurs des participants
		}).
		All(ctx)
	if err != nil {
		panic("error fetching events with participants to create messages: " + err.Error())
	}

	// Vérifier qu'il y a des événements avec des participants
	if len(events) == 0 {
		panic("No events with participants found to create messages")
	}

	// Parcourir chaque événement et ses participants
	for _, event := range events {
		// Vérifier si l'événement a des participants
		if len(event.Edges.Participants) == 0 {
			continue
		}

		// Créer des messages pour cet événement
		for _, participant := range event.Edges.Participants {
			if participant.Edges.User == nil {
				continue // Si le participant n'a pas d'utilisateur associé, ignorer
			}

			user := participant.Edges.User

			// Générer un nombre aléatoire de messages par participant
			numMessages := gofakeit.Number(1, 2)
			for i := 0; i < numMessages; i++ {
				content := gofakeit.Sentence(10) // Générer un contenu aléatoire

				// Créer le message
				_, err := client.Message.Create().
					SetContent(content).
					SetUserID(user.ID).    // Associer à l'utilisateur du participant
					SetEventID(event.ID).  // Associer à l'événement
					SetCreatedBy(user.ID). // Créé par l'utilisateur
					Save(ctx)

				if err != nil {
					panic("error creating message for event: " + err.Error())
				}
			}
		}
	}
}
