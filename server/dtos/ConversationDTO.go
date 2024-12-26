package dtos

type ConversationDTO struct {
	ConversationId   string `json:"conversationId"`
	ConversationName string `json:"conversationName"`
	Type             string `json:"type"`
}

func EntToConversationDTO(conversationId string, conversationName string, conversationType string) ConversationDTO {
	return ConversationDTO{
		ConversationId:   conversationId,
		ConversationName: conversationName,
		Type:             conversationType,
	}
}
