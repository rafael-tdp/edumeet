package dtos

// ResponseMessageDTO is a DTO that represents a response message
type DeleteMessageDTO struct {
	Action    string `json:"type"`
	UserID    string `json:"user_id"`
	MessageID string `json:"message_id"`
}

func EntToDeleteMessageDTO(messageID string, action string, userID string) *DeleteMessageDTO {
	return &DeleteMessageDTO{
		Action:    action,
		UserID:    userID,
		MessageID: messageID,
	}
}
