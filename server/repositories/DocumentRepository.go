package repositories

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/ent/document"
	"edumeet/ent/event"
	"edumeet/ent/eventdocument"
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

	document, err := r.client.Document.Query().
		Where(document.IDEQ(documentID)).
		WithUsers().
		WithEventDocuments().
		Only(context.Background())
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

func (r *DocumentRepository) CreateDocument(ctx context.Context, documentDTO dtos.DocumentDTO) (*ent.Document, error) {
	documentCreated, err := r.client.Document.Create().SetName(documentDTO.Name).SetPath(documentDTO.Path).Save(ctx)
	if err != nil {
		return nil, errors.New("error creating document")
	}

	if documentDTO.EventID != "" {
		_, err = r.client.EventDocument.Create().SetDocumentID(documentCreated.ID).SetEventID(documentDTO.EventID).SetType(documentDTO.Type).Save(ctx)
		if err != nil {
			return nil, errors.New("error adding document to event")
		}

	} else if documentDTO.MessageID != "" {
		_, err := documentCreated.Update().AddEventDocumentIDs(documentDTO.MessageID).Save(ctx)
		if err != nil {
			return nil, errors.New("error adding message to document")
		}
	}

	document := r.client.Document.Query().Where(document.IDEQ(documentCreated.ID)).WithEventDocuments().WithMessage().OnlyX(ctx)

	return document, nil
}

func (r *DocumentRepository) GetEventDocuments(eventID string) ([]*ent.EventDocument, error) {
	if r == nil {
		return nil, errors.New("client is not initialized")
	}

	eventDocuments, err := r.client.EventDocument.
		Query().
		Where(
			eventdocument.HasEventWith(event.IDEQ(eventID)),
		).
		WithDocument().All(context.Background())

	if err != nil {
		return nil, errors.New("error getting event documents: " + err.Error())
	}

	return eventDocuments, nil
}
