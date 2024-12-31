package dtos

type DeleteMessageEventDTO struct {
	Type      string `json:"type" validate:"required"`
	MessageId string `json:"messageId" validate:"required"`
	EventId   string `json:"eventId" validate:"required"`
}
