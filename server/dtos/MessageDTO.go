package dtos

import "edumeet/ent"

type MessageDTO struct {
	Message string `json:"message" validate:"required"`
	ID      string `json:"id"`
	Content string `json:"content"`
}

func EntToMessageDTO(message *ent.Message) *MessageDTO {
	return &MessageDTO{
		ID:      message.ID,
		Content: message.Content,
	}
}

func ConvertMessages(messages []*ent.Message) []MessageDTO {
	var messagesDTO []MessageDTO

	for _, message := range messages {
		messagesDTO = append(messagesDTO, *EntToMessageDTO(message))
	}

	return messagesDTO
}
