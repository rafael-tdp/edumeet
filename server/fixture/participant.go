package fixture

import (
	"context"
	"edumeet/ent"
	"edumeet/ent/event"
	"edumeet/ent/participant"
	"edumeet/ent/user"
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

	for _, ev := range events {
		_, err := client.Participant.Create().
			SetStatus("ACCEPTED").
			SetRequestedAt(time.Now()).
			SetJoinedAt(time.Now()).
			SetUserID(*ev.CreatedBy).
			SetEventID(ev.ID).
			Save(ctx)
		if err != nil {
			panic(err)
		}

		for i := 0; i < 3; i++ {
			var userId string
			for {
				userId = users[gofakeit.Number(0, len(users)-1)].ID
				if userId != *ev.CreatedBy {
					break
				}
			}

			_, err := client.Participant.Query().
				Where(participant.HasUserWith(user.IDEQ(userId))).
				Where(participant.HasEventWith(event.IDEQ(ev.ID))).
				First(ctx)
			if err == nil {
				continue
			}

			_, err = client.Participant.Create().
				SetStatus(func() string {
					if i == 2 {
						return "PENDING"
					}
					return "ACCEPTED"
				}()).
				SetRequestedAt(time.Now()).
				SetJoinedAt(time.Now()).
				SetUserID(userId).
				SetEventID(ev.ID).
				Save(ctx)
			if err != nil {
				panic(err)
			}
		}
	}
}
