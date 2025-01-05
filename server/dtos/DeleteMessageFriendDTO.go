package dtos

type DeleteMessageFriendDTO struct {
	Type       string `json:"type" validate:"required"`
	MessageId  string `json:"messageId" validate:"required"`
	FriendId   string `json:"friendId" validate:"required"`
	SenderId   string `json:"senderId" validate:"required"`
	ReceiverId string `json:"receiverId" validate:"required"`
}
