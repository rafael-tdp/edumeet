package dtos

type AIExerciseDTO struct {
	Statement string `json:"statement" validate:"required"`
}

type AICorrectionDTO struct {
	Exercise string `json:"exercise" validate:"required"`
}

type AIDocumentSaveDTO struct {
	Content string `json:"content" validate:"required"`
	DocType string `json:"doc_type" validate:"required,oneof=EXERCISE CORRECTION"`
	EventID string `json:"event_id" validate:"required"`
}
