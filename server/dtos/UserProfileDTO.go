package dtos

import (
	"edumeet/ent"
	"edumeet/utils"
)

type UserProfileDTO struct {
	Username string  `json:"username" validate:"required,min=3"`
	Bio      *string `json:"bio,omitempty"`
	Picture  *string `json:"picture,omitempty"`
	Address  string  `json:"address,omitempty"`
}

func UserProfileEntToDto(user *ent.User) (*UserProfileDTO, error) {
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
