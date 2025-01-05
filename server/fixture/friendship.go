package fixture

import (
	"context"
	"edumeet/ent"
	"edumeet/enums"

	"github.com/brianvoe/gofakeit/v7"
)

type FriendShip struct{}

func (m *FriendShip) GenerateFriendship(ctx context.Context, client *ent.Client) {
	users, err := client.User.Query().All(ctx)
	if err != nil {
		panic("error fetching users to create friendships: " + err.Error())
	}

	if len(users) == 0 {
		panic("No users found to create friendships")
	}

	for _, currentUser := range users {
		numFriends := gofakeit.Number(0, 3)
		usersShuffled := users
		gofakeit.ShuffleAnySlice(usersShuffled)
		for i := 0; i < numFriends; i++ {
			friend := usersShuffled[i]

			if currentUser.ID == friend.ID {
				continue
			}

			_, err = client.Friendship.Create().
				SetUser(currentUser).
				SetFriend(friend).
				SetStatus(string(enums.FriendAccepted)).
				Save(ctx)
			if err != nil {
				panic("error creating friendship: " + err.Error())
			}
		}
	}
}
