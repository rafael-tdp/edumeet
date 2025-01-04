package dtos

import (
	"edumeet/ent"
	"edumeet/ent/user"
	"time"
)

type UserDTO struct {
	ID        string     `json:"id" validate:"required"`
	Email     string     `json:"email" validate:"required,email"`
	Username  string     `json:"username" validate:"required,min=3"`
	Lastname  string     `json:"lastname,omitempty"`
	Firstname string     `json:"firstname,omitempty"`
	BirthDate time.Time  `json:"birthDate,omitempty"`
	Bio       *string    `json:"bio,omitempty"`
	Picture   *string    `json:"picture,omitempty"`
	Activated bool       `json:"activated,omitempty"`
	ReportNum int        `json:"reportNumber,omitempty"`
	Address   string     `json:"address,omitempty"`
	Role      user.Role  `json:"role" validate:"required,oneof=SUPERADMIN ADMIN USER"`
	Badges    []BadgeDTO `json:"badges,omitempty"`
}

func UserEntToDto(user *ent.User) (*UserDTO, error) {
	userDTO := &UserDTO{
		ID:        user.ID,
		Email:     user.Email,
		Username:  user.Username,
		Lastname:  user.Lastname,
		Firstname: user.Firstname,
		BirthDate: *user.BirthDate,
		Bio:       user.Bio,
		Picture:   user.Picture,
		Activated: user.Activated,
		ReportNum: user.ReportNumber,
		Address:   *user.Address,
		Role:      user.Role,
		Badges:    convertBadges(user.Edges.Badges),
	}

	return userDTO, nil
}

func EntToUserDTO(user *ent.User) *UserDTO {
	if user == nil {
		return nil
	}

	return &UserDTO{
		ID:        user.ID,
		Email:     user.Email,
		Username:  user.Username,
		Lastname:  user.Lastname,
		Firstname: user.Firstname,
		BirthDate: *user.BirthDate,
		Bio:       user.Bio,
		Picture:   user.Picture,
		Activated: user.Activated,
		ReportNum: user.ReportNumber,
		Address:   *user.Address,
		Role:      user.Role,
	}
}

func convertBadges(badges []*ent.Badge) []BadgeDTO {
	var badgesDTO []BadgeDTO
	for _, badge := range badges {
		badgeDTO := BadgeDTO{
			ID:                 badge.ID,
			Name:               badge.Name,
			Type:               badge.Type,
			NbRequirementEvent: badge.NbRequirementEvent,
			Svg:                badge.Svg,
		}
		badgesDTO = append(badgesDTO, badgeDTO)
	}
	return badgesDTO
}
