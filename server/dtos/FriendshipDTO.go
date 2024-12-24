package dtos

import "edumeet/ent"

type FriendshipDTO struct {
	ID       string `json:"id"`
	Status   string `json:"status" validate:"required, oneof=PENDING ACCEPTED"`
	FriendID string `json:"friendID"`
}

func FriendshipEntToDTO(friendship *ent.Friendship) (*FriendshipDTO, error) {
	return &FriendshipDTO{
		ID:       friendship.ID,
		Status:   friendship.Status,
		FriendID: friendship.Edges.Friend.ID,
	}, nil
}

func FriendshipsEntToDTO(friendships []*ent.Friendship) ([]FriendshipDTO, error) {
	friendshipsDTO := make([]FriendshipDTO, 0)
	for _, friendship := range friendships {
		friendshipDTO, err := FriendshipEntToDTO(friendship)
		if err != nil {
			return nil, err
		}
		friendshipsDTO = append(friendshipsDTO, *friendshipDTO)
	}
	return friendshipsDTO, nil
}
