package dtos

import (
	"edumeet/ent"
	"edumeet/ent/user"
	"errors"
	"time"
)

type UserDTO struct {
	ID        string    `json:"id"`
	Email     string    `json:"email"`
	Username  string    `json:"username"`
	Lastname  string    `json:"lastname"`
	Firstname string    `json:"firstname"`
	BirthDate time.Time `json:"birthDate"`
	Bio       *string   `json:"bio,omitempty"`
	Picture   *string   `json:"picture,omitempty"`
	Activated bool      `json:"activated"`
	ReportNum int       `json:"reportNumber"`
	Lng       *float64  `json:"lng,omitempty"`
	Lat       *float64  `json:"lat,omitempty"`
	Role      user.Role `json:"role"`
}

func ParseUserDTO(user *ent.User) (*UserDTO, error) {
	if user == nil {
		return nil, errors.New("user cannot be nil")
	}

	// Validation des champs obligatoires
	if user.ID == "" {
		return nil, errors.New("id is required")
	}

	if user.Email == "" {
		return nil, errors.New("email is required")
	}

	if user.Username == "" {
		return nil, errors.New("username is required")
	}

	if user.Role == "" {
		return nil, errors.New("role is required")
	}

	userDTO := &UserDTO{
		ID:        user.ID,
		Email:     user.Email,
		Username:  user.Username,
		Lastname:  user.Lastname,
		Firstname: user.Firstname,
		BirthDate: user.BirthDate,
		Bio:       user.Bio,
		Picture:   user.Picture,
		Activated: user.Activated,
		ReportNum: user.ReportNumber,
		Lng:       user.Lng,
		Lat:       user.Lat,
		Role:      user.Role,
	}

	return userDTO, nil
}
