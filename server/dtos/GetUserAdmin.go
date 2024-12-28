package dtos

import (
	"edumeet/ent"
	"time"
)

type GetUserAdmin struct {
	ID           string     `json:"id"`
	Email        string     `json:"email"`
	Firstname    string     `json:"firstname"`
	Lastname     string     `json:"lastname"`
	Username     string     `json:"username"`
	BirthDate    *time.Time `json:"birthDate"`
	Activated    bool       `json:"activated"`
	ReportNumber int        `json:"reportNumber"`
	Role         string     `json:"role"`
}

func UserEntToDtoAdmin(user *ent.User) (*GetUserAdmin, error) {
	return &GetUserAdmin{
		ID:           user.ID,
		Email:        user.Email,
		Firstname:    user.Firstname,
		Lastname:     user.Lastname,
		Username:     user.Username,
		BirthDate:    user.BirthDate,
		Activated:    user.Activated,
		ReportNumber: user.ReportNumber,
		Role:         user.Role.String(),
	}, nil
}
