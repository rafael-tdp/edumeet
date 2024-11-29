package repositories

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/ent/event"
	"edumeet/ent/participant"
	"edumeet/ent/remoteevent"
	"edumeet/ent/user"
)

type EventRepository struct {
	client *ent.Client
}

func NewEventRepository(client *ent.Client) *EventRepository {
	return &EventRepository{
		client: client,
	}
}

func (er *EventRepository) CreateEvent(ctx context.Context, event dtos.EventDTO) (*ent.Event, error) {
	createdEvent, err := er.client.Event.
		Create().
		SetTitle(event.Title).
		SetNbMaxUser(event.NbMaxUser).
		SetStartDate(event.StartDate).
		SetEndDate(event.EndDate).
		SetIsPrivate(event.IsPrivate).
		SetDescription(event.Description).
		SetInvitationLink(event.InvitationLink).
		Save(ctx)

	if err != nil {
		return nil, err
	}

	return createdEvent, nil
}

func (er *EventRepository) CreateRemoteEvent(ctx context.Context, remoteEvent dtos.RemoteEventDTO, eventID string) (*ent.RemoteEvent, error) {
	createdRemoteEvent, err := er.client.RemoteEvent.
		Create().
		SetEventID(eventID).
		SetURL(remoteEvent.URL).
		Save(ctx)

	if err != nil {
		return nil, err
	}

	return createdRemoteEvent, nil
}

func (er *EventRepository) CreatePhysicalEvent(ctx context.Context, physicalEvent dtos.PhysicalEventDTO, eventID string) (*ent.PhysicalEvent, error) {
	createdPhysicalEvent, err := er.client.PhysicalEvent.
		Create().
		SetEventID(eventID).
		SetLocation(physicalEvent.Location).
		SetLat(physicalEvent.Lat).
		SetLng(physicalEvent.Lng).
		Save(ctx)

	if err != nil {
		return nil, err
	}

	return createdPhysicalEvent, nil
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
		WithParticipants(func(pq *ent.ParticipantQuery) {
			pq.WithUser()
		}).
		WithRemoteEvent().
		WithPhysicalEvent().
		WithEventDocuments(func(edq *ent.EventDocumentQuery) {
			edq.WithDocument()
		}).
		First(context.Background())

	if err != nil {
		return nil, err
	}

	return event, nil
}

func (er *EventRepository) UpdateRemoteEvent(ctx context.Context, remoteEvent dtos.RemoteEventDTO, eventID string) (*ent.RemoteEvent, error) {
	updatedRemoteEvent, err := er.client.RemoteEvent.
		UpdateOneID(eventID).
		SetURL(remoteEvent.URL).
		Save(ctx)

	if err != nil {
		return nil, err
	}

	return updatedRemoteEvent, nil
}

func (er *EventRepository) UpdatePhysicalEvent(ctx context.Context, physicalEvent dtos.PhysicalEventDTO, eventID string) (*ent.PhysicalEvent, error) {
	updatedPhysicalEvent, err := er.client.PhysicalEvent.
		UpdateOneID(eventID).
		SetLocation(physicalEvent.Location).
		SetLat(physicalEvent.Lat).
		SetLng(physicalEvent.Lng).
		Save(context.Background())

	if err != nil {
		return nil, err
	}

	return updatedPhysicalEvent, nil
}

func (er *EventRepository) UpdateEvent(ctx context.Context, event dtos.EventDTO, eventID string) (*ent.Event, error) {
	updatedEvent, err := er.client.Event.
		UpdateOneID(eventID).
		SetTitle(event.Title).
		SetNbMaxUser(event.NbMaxUser).
		SetStartDate(event.StartDate).
		SetEndDate(event.EndDate).
		SetIsPrivate(event.IsPrivate).
		SetDescription(event.Description).
		SetInvitationLink(event.InvitationLink).
		Save(ctx)

	if err != nil {
		return nil, err
	}

	return updatedEvent, nil
}

func (er *EventRepository) GetEvents() ([]*ent.Event, error) {
	events, err := er.client.Event.Query().WithRemoteEvent().WithPhysicalEvent().WithParticipants().All(context.Background())
	if err != nil {
		return nil, err
	}

	return events, nil
}

func (er *EventRepository) GetEventsByUser(userID string) ([]*ent.Event, error) {
	events, err := er.client.Event.Query().
		Where(event.HasParticipantsWith(participant.HasUserWith(user.IDEQ(userID)))).WithParticipants().WithEventDocuments().All(context.Background())

	if err != nil {
		return nil, err
	}

	return events, nil
}
