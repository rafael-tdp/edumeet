package fixture

import (
	"context"
	"edumeet/ent"
	"edumeet/utils"

	"github.com/brianvoe/gofakeit/v7"
)

type Document struct{}

func (d *Document) GenerateDocument(ctx context.Context, client *ent.Client) error {

	users, err := client.User.Query().All(ctx)
	if err != nil {
		return err
	}

	ulid := utils.ULID{}
	for i := 0; i < 3; i++ {
		client.Document.Create().
			SetID(ulid.GenerateUlid()()).
			SetPath(gofakeit.URL()).
			SetName(gofakeit.Product().Name).
			SetCreatedBy(users[gofakeit.Number(0, len(users)-1)].ID).
			SaveX(ctx)
	}
	return nil
}

type EventDocument struct{}

func (ed *EventDocument) GenerateEventDocument(ctx context.Context, client *ent.Client) error {

	documents, err := client.Document.Query().All(ctx)
	if err != nil {
		return err
	}

	events, err := client.Event.Query().All(ctx)
	if err != nil {
		return err
	}

	ulid := utils.ULID{}
	for _, event := range events {
		for _, doc := range documents {
			client.EventDocument.Create().
				SetID(ulid.GenerateUlid()()).
				SetType(gofakeit.RandomString([]string{"exercise", "lesson", "test"})).
				SetDocumentID(doc.ID).
				SetEventID(event.ID).
				SaveX(ctx)
		}
	}
	return nil
}
