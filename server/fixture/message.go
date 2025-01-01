package fixture

import (
	"context"
	"edumeet/ent"
	"edumeet/ent/friendship"
	"edumeet/ent/user"
	"github.com/brianvoe/gofakeit/v7"
)

type Message struct{}

func (m *Message) GenerateMessagesForEvents(ctx context.Context, client *ent.Client) {
	events, err := client.Event.Query().
		WithParticipants(func(q *ent.ParticipantQuery) {
			q.WithUser()
		}).
		All(ctx)
	if err != nil {
		panic("error fetching events with participants to create messages: " + err.Error())
	}

	if len(events) == 0 {
		panic("No events with participants found to create messages")
	}

	for _, event := range events {
		if len(event.Edges.Participants) == 0 {
			continue
		}

		for _, participant := range event.Edges.Participants {
			if participant.Edges.User == nil {
				continue
			}

			user := participant.Edges.User

			if participant.Status != "ACCEPTED" {
				continue
			}

			numMessages := gofakeit.Number(1, 2)
			for i := 0; i < numMessages; i++ {
				content := gofakeit.Sentence(10)

				_, err := client.Message.Create().
					SetContent(content).
					SetUserID(user.ID).
					SetEventID(event.ID).
					SetCreatedBy(user.ID).
					Save(ctx)

				if err != nil {
					panic("error creating message for event: " + err.Error())
				}
			}
		}
	}
}

func (m *Message) GenerateMessagesForFriends(ctx context.Context, client *ent.Client) {
	users, err := client.User.Query().All(ctx)
	if err != nil {
		panic("error fetching users to create messages for friends: " + err.Error())
	}

	if len(users) == 0 {
		panic("No users found to create messages for friends")
	}

	for _, currentUser := range users {
		friends, err := client.Friendship.Query().
			Where(friendship.HasUserWith(user.IDEQ(currentUser.ID))).
			WithFriend().
			All(ctx)
		if err != nil {
			panic("error fetching friends for user: " + err.Error())
		}

		if len(friends) == 0 {
			continue
		}

		for _, friend := range friends {
			if friend.Status != "ACCEPTED" {
				continue
			}

			numMessages := gofakeit.Number(0, 3)
			for i := 0; i < numMessages; i++ {
				content := gofakeit.Sentence(10)

				_, err := client.Message.Create().
					SetContent(content).
					SetUserID(currentUser.ID).
					SetFriendshipID(friend.ID).
					SetCreatedBy(currentUser.ID).
					Save(ctx)

				if err != nil {
					panic("error creating message for friend: " + err.Error())
				}
			}
		}
	}
}
