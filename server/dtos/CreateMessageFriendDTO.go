package dtos

import "time"

type CreateMessageFriendDTO struct {
	Type         string    `json:"type" validate:"required"`
	Username     string    `json:"username" validate:"required"`
	MessageId    string    `json:"messageId" validate:"required"`
	SenderId     string    `json:"senderId" validate:"required"`
	ReceiverId   string    `json:"receiverId" validate:"required"`
	CreationDate time.Time `json:"creationDate" validate:"required"`
	Content      string    `json:"content" validate:"required"`
	PictureUser  string    `json:"pictureUser" validate:"required"`
}
