package dtos

import (
	"edumeet/ent"
	"errors"
)

type UserProfileDTO struct {
	Username string   `json:"username"`
	Bio      *string  `json:"bio,omitempty"`
	Picture  *string  `json:"picture,omitempty"`
	Lng      *float64 `json:"lng,omitempty"`
	Lat      *float64 `json:"lat,omitempty"`
}

func ParseUserProfileDTO(user *ent.User) (*UserProfileDTO, error) {
	if user == nil {
		return nil, errors.New("user cannot be nil")
	}

	if user.Username == "" {
		return nil, errors.New("username is required")
	}

	userProfileDTO := &UserProfileDTO{
		Username: user.Username,
		Bio:      user.Bio,
		Picture:  user.Picture,
		Lng:      user.Lng,
		Lat:      user.Lat,
	}
	return userProfileDTO, nil
}
