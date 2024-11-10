package repositories

import (
	"context"
	"edumeet/ent"
)

type EventRepository struct {
	client *ent.Client
}

func NewEventRepository(client *ent.Client) *EventRepository {
	return &EventRepository{
		client: client,
	}
}

func (er *EventRepository) CreateEvent(event *ent.Event) (*ent.Event, error) {
	createdEvent, err := er.client.Event.
		Create().
		SetTitle(event.Title).
		SetNbMaxUser(event.NbMaxUser).
		SetStartDate(event.StartDate).
		SetEndDate(event.EndDate).
		SetIsPrivate(event.IsPrivate).
		SetDescription(event.Description).
		SetInvitationLink(event.InvitationLink).
		Save(context.Background())

	if err != nil {
		return nil, err
	}

	return createdEvent, nil
}

func (er *EventRepository) CreateRemoteEvent(event *ent.Event, remoteEvent *ent.RemoteEvent) (*ent.RemoteEvent, error) {
	createdRemoteEvent, err := er.client.RemoteEvent.
		Create().
		SetEvent(event).
		SetURL(remoteEvent.URL).
		Save(context.Background())

	if err != nil {
		return nil, err
	}

	return createdRemoteEvent, nil
}
