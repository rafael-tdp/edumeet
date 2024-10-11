package dtos

import (
	"edumeet/ent/user"
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
