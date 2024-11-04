package dtos

import (
	"edumeet/ent"
	"edumeet/utils"
	"errors"
)

type UserProfileDTO struct {
	Username string  `json:"username"`
	Bio      *string `json:"bio,omitempty"`
	Picture  *string `json:"picture,omitempty"`
	Address  string  `json:"address,omitempty"`
}

func ParseUserProfileDTO(user *ent.User) (*UserProfileDTO, error) {
	if user == nil {
		return nil, errors.New("user cannot be nil")
	}

	if user.Username == "" {
		return nil, errors.New("username is required")
	}

	address, err := utils.GetAddress(*user.Lat, *user.Lng)

	if err != nil {
		return nil, err
	}

	userProfileDTO := &UserProfileDTO{
		Username: user.Username,
		Bio:      user.Bio,
		Picture:  user.Picture,
		Address:  address,
	}
	return userProfileDTO, nil
}
