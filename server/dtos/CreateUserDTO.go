package dtos

import (
	"edumeet/ent/user"
	"time"
)

type CreateUserDTO struct {
	Email     string    `json:"email"`
	Password  string    `json:"password"`
	Firstname string    `json:"firstname"`
	Lastname  string    `json:"lastname"`
	Username  string    `json:"username"`
	Role      user.Role `json:"role"`
	Birthdate time.Time `json:"birthdate"`
}
