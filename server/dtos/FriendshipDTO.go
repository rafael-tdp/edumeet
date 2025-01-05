package dtos

import (
	"edumeet/ent"
	"edumeet/enums"
)

type FriendshipDTO struct {
	ID             string `json:"id"`
	FriendID       string `json:"friendID"`
	Status         string `json:"status"`
	FriendUsername string `json:"friendUsername"`
	FriendPicture  string `json:"friendPicture"`
}

func FriendshipEntToDTO(friendship *ent.Friendship, friendId string, friendUsername string, friendPicture string) (*FriendshipDTO, error) {
	return &FriendshipDTO{
		ID:             friendship.ID,
		FriendID:       friendId,
		Status:         friendship.Status,
		FriendUsername: friendUsername,
		FriendPicture:  friendPicture,
	}, nil
}

func FriendshipsEntToDTO(friendships []*ent.Friendship, currentUserId string, status string) ([]FriendshipDTO, error) {
	friendshipsDTO := make([]FriendshipDTO, 0)
	for _, friendship := range friendships {
		if status == string(enums.FriendPending) {
			friendshipDTO, err := FriendshipEntToDTO(friendship, friendship.Edges.User.ID, friendship.Edges.User.Username, *friendship.Edges.User.Picture)
			if err != nil {
				return nil, err
			}
			friendshipsDTO = append(friendshipsDTO, *friendshipDTO)
		} else {
			if friendship.Edges.User.ID == currentUserId {
				friendshipDTO, err := FriendshipEntToDTO(friendship, friendship.Edges.Friend.ID, friendship.Edges.Friend.Username, *friendship.Edges.Friend.Picture)
				if err != nil {
					return nil, err
				}
				friendshipsDTO = append(friendshipsDTO, *friendshipDTO)
			} else {
				friendshipDTO, err := FriendshipEntToDTO(friendship, friendship.Edges.User.ID, friendship.Edges.User.Username, *friendship.Edges.User.Picture)
				if err != nil {
					return nil, err
				}
				friendshipsDTO = append(friendshipsDTO, *friendshipDTO)
			}
		}
	}
	return friendshipsDTO, nil
}
