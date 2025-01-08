package dtos

import (
	"edumeet/ent"
	"edumeet/utils"
)

type UserProfileDTO struct {
	Username             string     `json:"username" validate:"required,min=3"`
	Bio                  *string    `json:"bio,omitempty"`
	Picture              *string    `json:"picture,omitempty"`
	Address              string     `json:"address,omitempty"`
	Email                string     `json:"email,omitempty"`
	Birthdate            string     `json:"birthDate,omitempty"`
	Badges               []BadgeDTO `json:"badges,omitempty"`
	NbFriends            int        `json:"nbFriends,omitempty"`
	NbParticipatedEvents int        `json:"nbParticipatedEvents,omitempty"`
	IsMyFriend           bool       `json:"isMyFriend"`
}

func UserProfileEntToDto(user *ent.User, isMyFriend bool) (*UserProfileDTO, error) {
	address, err := utils.GetAddress(*user.Lat, *user.Lng)

	if err != nil {
		return nil, err
	}

	userProfileDTO := &UserProfileDTO{
		Username:   user.Username,
		Bio:        user.Bio,
		Picture:    user.Picture,
		Address:    address,
		Email:      user.Email,
		Birthdate:  user.BirthDate.Format("2006-01-02"),
		Badges:     convertBadges(user.Edges.Badges),
		IsMyFriend: isMyFriend,
	}
	return userProfileDTO, nil
}
