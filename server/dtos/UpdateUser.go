package dtos

import (
	"edumeet/ent/user"
	"time"
)

type UpdateUserDTO struct {
	Id           string    `json:"id"`
	Email        string    `json:"email" validate:"required,email"`
	Username     string    `json:"username" validate:"required"`
	Firstname    string    `json:"firstname" validate:"required"`
	Lastname     string    `json:"lastname" validate:"required"`
	Birthdate    time.Time `json:"birthdate"`
	Bio          string    `json:"bio"`
	Picture      string    `json:"picture"`
	ReportNumber int       `json:"reportNumber"`
	Address      string    `json:"address"`
	Role         user.Role `json:"role"`
}

type UpdateUserAdminDTO struct {
	Id        string    `json:"id"`
	Email     string    `json:"email" validate:"required,email"`
	Username  string    `json:"username" validate:"required"`
	Firstname string    `json:"firstname" validate:"required"`
	Lastname  string    `json:"lastname" validate:"required"`
	Role      user.Role `json:"role"`
	Activated bool      `json:"activated"`
}
