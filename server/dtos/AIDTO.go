package dtos

type AIExerciseDTO struct {
	Statement string `json:"statement" validate:"required"`
}

type AICorrectionDTO struct {
	Exercise string `json:"exercise" validate:"required"`
}
