package dtos

import "edumeet/ent"

// ResponseMessageDTO is a DTO that represents a response message
type ResponseMessageDTO struct {
	Action    string   `json:"type"`
	UserID    string   `json:"user_id"`
	Message   string   `json:"message"`
	Documents []string `json:"documents"`
	CreatedAt string   `json:"created_at"`
}

func EntToResponseMessageDTO(message *ent.Message, documents []string, action string, userID string) *ResponseMessageDTO {
	return &ResponseMessageDTO{
		Action:    action,
		UserID:    userID,
		Message:   message.Content,
		Documents: documents,
		CreatedAt: message.CreatedAt.String(),
	}
}
