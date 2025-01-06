package repositories

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/ent/event"
	"edumeet/ent/message"
	"edumeet/ent/participant"
	"edumeet/ent/remoteevent"
	"edumeet/ent/subject"
	"edumeet/ent/user"
	"edumeet/structures"
	"edumeet/utils"
	"fmt"
	"strings"

	"github.com/samber/lo"
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
	subjects := make([]*ent.Subject, 0)

	for _, subjectIds := range event.Subjects {
		entSubject, err := er.client.Subject.Query().Where(subject.IDEQ(subjectIds)).First(ctx)
		if err != nil {
			return nil, err
		}
		subjects = append(subjects, entSubject)
	}

	createdEvent, err := er.client.Event.
		Create().
		SetTitle(event.Title).
		SetStartDate(event.StartDate).
		SetEndDate(event.EndDate).
		SetIsPrivate(event.IsPrivate).
		SetDescription(event.Description).
		AddSubjects(subjects...).
		SetCode(lo.RandomString(6, lo.LettersCharset)).
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
	lat, lng, err := utils.GetLatLng(physicalEvent.Location)

	if err != nil {
		return nil, err
	}

	createdPhysicalEvent, err := er.client.PhysicalEvent.
		Create().
		SetEventID(eventID).
		SetLocation(physicalEvent.Location).
		SetLat(lat).
		SetLng(lng).
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
		WithSubjects().
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
		SetStartDate(event.StartDate).
		SetEndDate(event.EndDate).
		SetIsPrivate(event.IsPrivate).
		SetDescription(event.Description).
		Save(ctx)

	if err != nil {
		return nil, err
	}

	return updatedEvent, nil
}

func (er *EventRepository) GetEventsWithFilters(filters structures.EventFilters, limit, offset int) ([]*ent.Event, error) {
	query := er.client.Event.Query().
		WithRemoteEvent().
		WithPhysicalEvent().
		WithParticipants(
			func(pq *ent.ParticipantQuery) {
				pq.WithUser()
			},
		)

	// Filtrer par type d'événement
	if filters.Type == "remote" {
		query = query.Where(event.HasRemoteEvent())
	} else if filters.Type == "physical" {
		query = query.Where(event.HasPhysicalEvent())
	}

	// Filtrer par subjects (string avec des IDs séparés par des virgules)
	if filters.Subjects != "" {
		subjectIDs := strings.Split(filters.Subjects, ",") // Convertir la chaîne en slice
		query = query.Where(event.HasSubjectsWith(subject.IDIn(subjectIDs...)))
	}

	// Exécuter la requête
	events, err := query.
		Limit(limit).
		Offset(offset).
		All(context.Background())
	if err != nil {
		return nil, fmt.Errorf("failed to fetch events: %v", err)
	}

	return events, nil
}

func (er *EventRepository) GetEventsByUser(userID string) ([]*ent.Event, error) {
	events, err := er.client.Event.Query().
		Where(
			event.Or(
				event.HasParticipantsWith(participant.HasUserWith(user.IDEQ(userID))),
				event.CreatedBy(userID),
			),
		).
		WithParticipants(
			func(pq *ent.ParticipantQuery) {
				pq.WithUser()
			},
		).
		WithEventDocuments().
		All(context.Background())

	if err != nil {
		return nil, err
	}

	return events, nil
}

func (er *EventRepository) GetEventsCreatedByUser(userID string) ([]*ent.Event, error) {
	events, err := er.client.Event.Query().
		Where(event.CreatedBy(userID)).
		WithParticipants().
		WithEventDocuments().
		WithRemoteEvent().
		WithPhysicalEvent().
		All(context.Background())

	if err != nil {
		return nil, err
	}

	return events, nil
}

func (er *EventRepository) GetEventByCode(code string) (*ent.Event, error) {
	event, err := er.client.Event.Query().
		Where(event.Code(code)).
		WithParticipants(func(pq *ent.ParticipantQuery) {
			pq.WithUser()
		}).
		First(context.Background())

	if err != nil {
		return nil, err
	}

	return event, nil
}

func (er *EventRepository) GetEventCode(eventId string) (*ent.Event, error) {
	event, err := er.client.Event.Query().
		Where(event.ID(eventId)).
		First(context.Background())

	if err != nil {
		return nil, err
	}

	return event, nil
}

func (er *EventRepository) UpdateEventSubjects(ctx context.Context, eventId string, subjectIDs []string) (*ent.Event, error) {
	event, err := er.client.Event.Query().Where(event.IDEQ(eventId)).WithSubjects().Only(ctx)
	if err != nil {
		return nil, err
	}

	_, err = event.Update().ClearSubjects().Save(ctx)
	if err != nil {
		return nil, err
	}

	for _, subjectID := range subjectIDs {
		subject, err := er.client.Subject.Query().Where(subject.IDEQ(subjectID)).Only(ctx)
		if err != nil {
			return nil, err
		}

		_, err = event.Update().AddSubjects(subject).Save(ctx)
		if err != nil {
			return nil, err
		}
	}

	return event, nil
}

func (er *EventRepository) GetLastMessagesByEvent(eventID string) ([]dtos.MessageDTO, error) {
	messages, err := er.client.Message.
		Query().
		Where(message.HasEventWith(event.IDEQ(eventID))).
		Order(ent.Desc(message.FieldCreatedAt)).
		Limit(5).
		WithUser(
			func(uq *ent.UserQuery) {
				uq.Select(user.FieldID, user.FieldFirstname, user.FieldLastname, user.FieldUsername, user.FieldPicture)
			},
		).
		All(context.Background())

	if err != nil {
		return nil, err
	}

	var messageDTOs []dtos.MessageDTO
	for _, msg := range messages {
		messageDTOs = append(messageDTOs, dtos.MessageDTO{
			ID:      msg.ID,
			Content: msg.Content,
			User: dtos.UserDTO{
				ID:        msg.Edges.User.ID,
				Firstname: msg.Edges.User.Firstname,
				Lastname:  msg.Edges.User.Lastname,
				Username:  msg.Edges.User.Username,
				Picture:   msg.Edges.User.Picture,
			},
		})
	}

	return messageDTOs, nil
}

func (er *EventRepository) UpdateEventAdmin(ctx context.Context, event dtos.UpdateEventAdminDTO, eventID string) (*ent.Event, error) {

	updatedEvent, err := er.client.Event.
		UpdateOneID(eventID).
		SetTitle(event.Title).
		SetIsPrivate(event.IsPrivate).
		Save(ctx)

	if err != nil {
		return nil, err
	}

	return updatedEvent, nil
}

func (er *EventRepository) GetEvents() ([]*ent.Event, error) {
	events, err := er.client.Event.Query().
		WithParticipants().
		WithSubjects().
		WithRemoteEvent().
		WithPhysicalEvent().
		All(context.Background())

	if err != nil {
		return nil, err
	}
	return events, nil
}
