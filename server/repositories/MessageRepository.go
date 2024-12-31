package repositories

import (
	"context"
	"edumeet/ent/event"

	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/ent/message"
)

type MessageRepository struct {
	client *ent.Client
}

func NewMessageRepository(client *ent.Client) *MessageRepository {
	return &MessageRepository{client: client}
}

func (mr *MessageRepository) GetLastMessagesByEvent(eventID string) ([]dtos.MessageDTO, error) {
	messages, err := mr.client.Message.
		Query().
		Where(message.HasEventWith(event.IDEQ(eventID))).
		Order(ent.Desc(message.FieldCreatedAt)).
		Limit(5).
		All(context.Background())

	if err != nil {
		return nil, err
	}

	var messageDTOs []dtos.MessageDTO
	for _, msg := range messages {
		messageDTOs = append(messageDTOs, dtos.MessageDTO{
			ID:      msg.ID,
			Content: msg.Content,
		})
	}

	return messageDTOs, nil
}
