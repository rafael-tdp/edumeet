package dtos

type GetChatDTO struct {
	EventID   string   `json:"eventID"`
	Message   string   `json:"message"`
	MessageID string   `json:"messageID"`
	Documents []string `json:"documents"`
	CreatedAt string   `json:"createdAt"`
	CreatedBy string   `json:"createdBy"`
}

func EntToGetChatDTO(eventID, message, messageID, createdAt, createdBy string, documents []string) *GetChatDTO {
	return &GetChatDTO{
		EventID:   eventID,
		Message:   message,
		MessageID: messageID,
		Documents: documents,
		CreatedAt: createdAt,
		CreatedBy: createdBy,
	}
}
