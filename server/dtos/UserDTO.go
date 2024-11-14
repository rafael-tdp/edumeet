package dtos

import (
	"edumeet/ent"
	"edumeet/ent/user"
	"edumeet/utils"
	"time"
)

type UserDTO struct {
	ID        string    `json:"id" validate:"required"`
	Email     string    `json:"email" validate:"required,email"`
	Username  string    `json:"username" validate:"required,min=3"`
	Lastname  string    `json:"lastname"`
	Firstname string    `json:"firstname"`
	BirthDate time.Time `json:"birthDate,omitempty"`
	Bio       *string   `json:"bio,omitempty"`
	Picture   *string   `json:"picture,omitempty"`
	Activated bool      `json:"activated"`
	ReportNum int       `json:"reportNumber"`
	Address   string    `json:"address,omitempty"`
	Role      user.Role `json:"role" validate:"required,oneof=SUPERADMIN ADMIN USER"`
}

func UserEntToDto(user *ent.User) (*UserDTO, error) {
	address, err := utils.GetAddress(*user.Lat, *user.Lng)

	if err != nil {
		return nil, err
	}

	userDTO := &UserDTO{
		ID:        user.ID,
		Email:     user.Email,
		Username:  user.Username,
		Lastname:  user.Lastname,
		Firstname: user.Firstname,
		//BirthDate: *user.BirthDate,
		Bio:       user.Bio,
		Picture:   user.Picture,
		Activated: user.Activated,
		ReportNum: user.ReportNumber,
		Address:   address,
		Role:      user.Role,
	}

	return userDTO, nil
}
