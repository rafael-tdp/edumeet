package dtos

type CreateMessageEventDTO struct {
	Type         string `json:"type" validate:"required"`
	Username     string `json:"username" validate:"required"`
	MessageId    string `json:"messageId" validate:"required"`
	EventId      string `json:"eventId" validate:"required"`
	CreationDate string `json:"creationDate" validate:"required"`
	Content      string `json:"content" validate:"required"`
}
