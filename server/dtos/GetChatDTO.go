package dtos

type GetChatDTO struct {
	Message   string `json:"message"`
	MessageID string `json:"messageID"`
	CreatedBy string `json:"createdBy"`
}

func (e *GetChatDTO) GetCreatedBy() *string {
	return &e.CreatedBy
}

func EntToGetChatDTO(message, messageID, createdBy string) *GetChatDTO {
	return &GetChatDTO{
		Message:   message,
		MessageID: messageID,
		CreatedBy: createdBy,
	}
}
