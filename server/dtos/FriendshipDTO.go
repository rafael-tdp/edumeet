package dtos

import "edumeet/ent"

type FriendshipDTO struct {
	ID   string `json:"id"`
	Name string `json:"status" validate:"required, oneof=PENDING ACCEPTED"`
}

func FriendshipEntToDTO(friendship *ent.Friendship) *FriendshipDTO {
	return &FriendshipDTO{
		ID:   friendship.ID,
		Name: friendship.Status,
	}
}
