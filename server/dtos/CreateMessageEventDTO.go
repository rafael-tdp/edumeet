package dtos

import "time"

type CreateMessageEventDTO struct {
	Type         string    `json:"type" validate:"required"`
	Username     string    `json:"username" validate:"required"`
	MessageId    string    `json:"messageId" validate:"required"`
	EventId      string    `json:"eventId" validate:"required"`
	CreationDate time.Time `json:"creationDate" validate:"required"`
	Content      string    `json:"content" validate:"required"`
}
