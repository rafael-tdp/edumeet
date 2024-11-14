package dtos

import "edumeet/ent"

type BadgeDTO struct {
	ID                 string `json:"id,omitempty"`
	Name               string `json:"name" validate:"required,min=3"`
	Svg                string `json:"svg" validate:"required"`
	NbRequirementEvent int    `json:"nbRequirementEvent" validate:"required,min=1"`
	Type               string `json:"type" validate:"required,oneof=EVENT USER MESSAGE"`
}

func BadgeEntToDTO(badge *ent.Badge) BadgeDTO {
	return BadgeDTO{
		ID:                 badge.ID,
		Name:               badge.Name,
		Type:               badge.Type,
		NbRequirementEvent: badge.NbRequirementEvent,
		Svg:                badge.Svg,
	}
}
