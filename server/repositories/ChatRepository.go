package repositories

import (
	"context"
	"edumeet/ent"
	"edumeet/ent/event"
	"edumeet/ent/message"
)

type ChatRepository struct {
	client *ent.Client
}

func NewChatRepository(client *ent.Client) *ChatRepository {
	return &ChatRepository{
		client: client,
	}
}

func (cr *ChatRepository) CreateMessage(ctx context.Context, message string, eventID string, userID string) (*ent.Message, error) {
	//flush message in DB
	messageCreated, err := cr.client.Message.Create().
		SetContent(message).
		SetUserID(userID).
		SetEventID(eventID).
		Save(ctx)

	if err != nil {
		return nil, err
	}

	return messageCreated, nil
}

func (cr *ChatRepository) CreateMessageFriend(ctx context.Context, message string, friendId string, userID string) (*ent.Message, error) {
	//flush message in DB
	messageCreated, err := cr.client.Message.Create().
		SetContent(message).
		SetUserID(userID).
		SetFriendshipID(friendId).
		Save(ctx)

	if err != nil {
		return nil, err
	}

	return messageCreated, nil
}

func (cr *ChatRepository) DeleteMessage(messageID string) error {
	err := cr.client.Message.DeleteOneID(messageID).Exec(context.Background())
	if err != nil {
		return err
	}
	return nil
}

func (cr *ChatRepository) GetChatsByEventID(eventID string) ([]*ent.Message, error) {

	messages, err := cr.client.Message.Query().
		Where(message.HasEventWith(event.IDEQ(eventID))).
		WithUser().
		All(context.Background())

	if err != nil {
		return nil, err
	}

	return messages, nil
}

func (cr *ChatRepository) GetChat(messageID string) (*ent.Message, error) {
	message, err := cr.client.Message.Query().
		Where(message.IDEQ(messageID)).
		WithUser().
		WithEvent().
		Only(context.Background())

	if err != nil {
		return nil, err
	}

	return message, nil
}
