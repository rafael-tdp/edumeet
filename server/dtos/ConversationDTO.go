package dtos

type ConversationDTO struct {
	ConversationId      string `json:"conversationId"`
	ConversationName    string `json:"conversationName"`
	Type                string `json:"type"`
	LastMessage         string `json:"lastMessage"`
	LastMessageDate     string `json:"lastMessageDate"`
	LastMessageUsername string `json:"lastMessageUsername"`
}

func EntToConversationDTO(conversationId string, conversationName string, conversationType string, lastMessage string, lastMessageDate string, lastMessageUsername string) ConversationDTO {
	return ConversationDTO{
		ConversationId:      conversationId,
		ConversationName:    conversationName,
		Type:                conversationType,
		LastMessage:         lastMessage,
		LastMessageDate:     lastMessageDate,
		LastMessageUsername: lastMessageUsername,
	}
}
