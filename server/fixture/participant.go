package fixture

import (
	"context"
	"edumeet/ent"
	"time"

	"github.com/brianvoe/gofakeit/v7"
)

type Participant struct{}

func (e *Participant) GenerateParticipant(ctx context.Context, client *ent.Client) {
	users, err := client.User.Query().All(ctx)
	if err != nil {
		panic(err)
	}

	events, err := client.Event.Query().All(ctx)
	if err != nil {
		panic(err)
	}

	// create 2 or 3 participants for each event
	for _, event := range events {
		for i := 0; i < gofakeit.Number(2, 3); i++ {
			_, err := client.Participant.Create().
				SetStatus("ACCEPTED").
				SetRequestedAt(time.Now()).
				SetJoinedAt(time.Now()).
				SetUserID(users[gofakeit.Number(0, len(users)-1)].ID).
				SetEventID(event.ID).
				Save(ctx)
			if err != nil {
				panic(err)
			}
		}
	}
}
