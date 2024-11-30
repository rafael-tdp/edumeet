package repositories

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
)

type ChatRepository struct {
	client *ent.Client
}

func NewChatRepository(client *ent.Client) *ChatRepository {
	return &ChatRepository{
		client: client,
	}
}

func (cr *ChatRepository) CreateMessage(ctx context.Context, messageDTO dtos.MessageDTO, eventID string, userID string) (*ent.Message, error) {
	//flush message in DB
	message, err := cr.client.Message.Create().
		SetContent(messageDTO.Message).
		SetUserID(userID).
		SetEventID(eventID).
		Save(ctx)

	if err != nil {
		return nil, err
	}

	return message, nil
}

func (cr *ChatRepository) DeleteMessage(messageID string) error {
	err := cr.client.Message.DeleteOneID(messageID).Exec(context.Background())
	if err != nil {
		return err
	}
	return nil
}
