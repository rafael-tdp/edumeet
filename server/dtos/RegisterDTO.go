package dtos

import "time"

type RegisterDTO struct {
	Email     string    `json:"email" validate:"required,email"`
	Username  string    `json:"username" validate:"required"`
	Lastname  string    `json:"lastname" validate:"required"`
	Firstname string    `json:"firstname" validate:"required"`
	Password  string    `json:"password" validate:"required"`
	BirthDate time.Time `json:"birthDate" validate:"required"`
	Bio       *string   `json:"bio,omitempty"`
	Picture   *string   `json:"picture,omitempty"`
	Lng       *float64  `json:"lng,omitempty"`
	Lat       *float64  `json:"lat,omitempty"`
}
