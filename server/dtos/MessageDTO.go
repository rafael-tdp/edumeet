package dtos

type MessageDTO struct {
	Message string `json:"message" validate:"required"`
}
