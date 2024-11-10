package repositories

import (
	"context"
	"edumeet/ent"
	"edumeet/ent/event"
	"edumeet/ent/remoteevent"
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

func (er *EventRepository) DeleteEvent(eventID string) error {
	err := er.client.Event.
		DeleteOneID(eventID).
		Exec(context.Background())

	if err != nil {
		return err
	}

	return nil
}

func (er *EventRepository) GetRemoteEvent(eventID string) (*ent.RemoteEvent, error) {
	remoteEvent, err := er.client.RemoteEvent.
		Query().
		Where(remoteevent.ID(eventID)).
		WithEvent().
		First(context.Background())

	if err != nil {
		return nil, err
	}

	return remoteEvent, nil
}

func (er *EventRepository) GetEvent(eventID string) (*ent.Event, error) {
	event, err := er.client.Event.
		Query().
		Where(event.ID(eventID)).
		First(context.Background())

	if err != nil {
		return nil, err
	}

	return event, nil
}

func (er *EventRepository) UpdateRemoteEvent(eventID string, remoteEvent *ent.RemoteEvent) (*ent.RemoteEvent, error) {
	updatedRemoteEvent, err := er.client.RemoteEvent.
		UpdateOneID(eventID).
		SetURL(remoteEvent.URL).
		Save(context.Background())

	if err != nil {
		return nil, err
	}

	return updatedRemoteEvent, nil
}

func (er *EventRepository) UpdateEvent(eventID string, event *ent.Event) (*ent.Event, error) {
	updatedEvent, err := er.client.Event.
		UpdateOneID(eventID).
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

	return updatedEvent, nil
}
