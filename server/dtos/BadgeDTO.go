package dtos

type BadgeDTO struct {
	ID                 string `json:"id,omitempty"`
	Name               string `json:"name" validate:"required,min=3"`
	Svg                string `json:"svg" validate:"required"`
	NbRequirementEvent int    `json:"nbRequirementEvent" validate:"required,min=1"`
	Type               string `json:"type" validate:"required,oneof=EVENT USER MESSAGE"`
}
