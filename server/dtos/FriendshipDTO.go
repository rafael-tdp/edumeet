package dtos

import "edumeet/ent"

type FriendshipDTO struct {
	ID     string         `json:"id"`
	Status string         `json:"status" validate:"required, oneof=PENDING ACCEPTED"`
	User   UserProfileDTO `json:"user"`
}

func FriendshipEntToDTO(friendship *ent.Friendship) (*FriendshipDTO, error) {
	user, err := UserProfileEntToDto(friendship.Edges.User)
	if err != nil {
		return nil, err
	}

	return &FriendshipDTO{
		ID:     friendship.ID,
		Status: friendship.Status,
		User:   *user,
	}, nil
}
