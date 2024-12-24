package dtos

type CreateMessageFriendDTO struct {
	Type         string `json:"type" validate:"required"`
	Username     string `json:"username" validate:"required"`
	MessageId    string `json:"messageId" validate:"required"`
	SenderId     string `json:"senderId" validate:"required"`
	ReceiverId   string `json:"receiverId" validate:"required"`
	CreationDate string `json:"creationDate" validate:"required"`
	Content      string `json:"content" validate:"required"`
}
