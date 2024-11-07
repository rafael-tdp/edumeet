package repositories

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/ent/document"
	"edumeet/ent/event"
	"edumeet/ent/message"
	"edumeet/ent/user"
	"errors"
)

type DocumentRepository struct {
	client *ent.Client
}

func NewDocumentRepository(client *ent.Client) *DocumentRepository {
	return &DocumentRepository{
		client: client,
	}
}

func (r *DocumentRepository) GetDocumentById(documentID string) (*ent.Document, error) {

	document, err := r.client.Document.Query().Where(document.IDEQ(documentID)).Only(context.Background())
	if err != nil {
		return nil, errors.New("document not found")
	}

	return document, nil
}

func (r *DocumentRepository) DeleteDocument(documentID string) error {

	document, err := r.client.Document.Query().Where(document.IDEQ(documentID)).Only(context.Background())
	if err != nil {
		return errors.New("document not found")
	}

	err = r.client.Document.DeleteOne(document).Exec(context.Background())
	if err != nil {
		return errors.New("error deleting document")
	}

	return nil
}

func (r *DocumentRepository) CreateDocument(documentDTO dtos.DocumentDTO) error {

	_, err := r.client.Document.Create().SetPath(documentDTO.Path).Save(context.Background())
	if err != nil {
		return errors.New("error creating document")
	}

	return nil
}

func (r *DocumentRepository) GetEntity(entityType string, entityID string) (interface{}, error) {
	switch entityType {
	case "USER":
		user, err := r.client.User.Query().Where(user.IDEQ(entityID)).Only(context.Background())
		if err != nil {
			return nil, errors.New("user not found")
		}
		return user, nil
	case "MESSAGE":
		message, err := r.client.Message.Query().Where(message.IDEQ(entityID)).Only(context.Background())
		if err != nil {
			return nil, errors.New("message not found")
		}
		return message, nil
	case "EVENT":
		event, err := r.client.Event.Query().Where(event.IDEQ(entityID)).Only(context.Background())
		if err != nil {
			return nil, errors.New("event not found")
		}
		return event, nil
	default:
		return nil, errors.New("invalid entity type")
	}
}
