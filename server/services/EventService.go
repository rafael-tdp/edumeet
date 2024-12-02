package services

import (
	"context"
	"edumeet/dtos"
	"edumeet/repositories"
)

type EventService struct {
	eventRepository       *repositories.EventRepository
	participantRepository *repositories.ParticipantRepository
}

func NewEventService(eventRepository *repositories.EventRepository, participantRepository *repositories.ParticipantRepository) *EventService {
	return &EventService{
		eventRepository:       eventRepository,
		participantRepository: participantRepository,
	}
}

func (es *EventService) CreateEvent(ctx context.Context, eventDTO dtos.EventDTO, userId string) (*dtos.EventDTO, error) {

	event, err := es.eventRepository.CreateEvent(ctx, eventDTO)

	if err != nil {
		return nil, err
	}

	if nil != eventDTO.RemoteEventDTO {
		_, err := es.eventRepository.CreateRemoteEvent(ctx, *eventDTO.RemoteEventDTO, event.ID)
		if err != nil {
			return nil, err
		}
	} else {
		_, err := es.eventRepository.CreatePhysicalEvent(ctx, *eventDTO.PhysicalEventDTO, event.ID)
		if err != nil {
			return nil, err
		}
	}

	eventCreatedWithEdge, err := es.eventRepository.GetEvent(event.ID)
	if err != nil {
		return nil, err
	}
	return dtos.EntToEventDTO(eventCreatedWithEdge), nil
}

func (es *EventService) DeleteEvent(eventID string) error {
	err := es.eventRepository.DeleteEvent(eventID)
	if err != nil {
		return err
	}

	return nil
}

func (es *EventService) GetEvent(eventID string) (*dtos.EventDTO, error) {

	event, err := es.eventRepository.GetEvent(eventID)

	if err != nil {
		return nil, err
	}

	return dtos.EntToEventDTO(event), nil
}

func (es *EventService) UpdateEvent(ctx context.Context, event dtos.EventDTO, eventID string) (*dtos.EventDTO, error) {

	currentEvent, errGetEvent := es.eventRepository.GetEvent(eventID)

	if errGetEvent != nil {
		return nil, errGetEvent
	}

	_, errUpdateEvent := es.eventRepository.UpdateEvent(ctx, event, eventID)

	if errUpdateEvent != nil {
		return nil, errUpdateEvent
	}

	if currentEvent.Edges.RemoteEvent != nil {
		_, err := es.eventRepository.UpdateRemoteEvent(ctx, *event.RemoteEventDTO, currentEvent.Edges.RemoteEvent.ID)
		if err != nil {
			return nil, err
		}
	} else {
		_, err := es.eventRepository.UpdatePhysicalEvent(ctx, *event.PhysicalEventDTO, currentEvent.Edges.PhysicalEvent.ID)
		if err != nil {
			return nil, err
		}
	}

	eventCreatedWithEdge, err := es.eventRepository.GetEvent(currentEvent.ID)
	if err != nil {
		return nil, err
	}
	return dtos.EntToEventDTO(eventCreatedWithEdge), nil
}

func (es *EventService) GetAllEvents() ([]dtos.EventWithTypeDTO, error) {
	events, err := es.eventRepository.GetEvents()
	if err != nil {
		return nil, err
	}

	var eventsWithType []dtos.EventWithTypeDTO

	for _, event := range events {
		if event.Edges.RemoteEvent != nil {
			eventsWithType = append(eventsWithType, dtos.EventWithTypeDTO{
				ID:                event.ID,
				StartDate:         event.StartDate,
				EndDate:           event.EndDate,
				IsPrivate:         event.IsPrivate,
				Title:             event.Title,
				Description:       event.Description,
				InvitationLink:    event.InvitationLink,
				Image:             event.Image,
				RemoteEventDTO:    dtos.EntToRemoteEventDTO(event.Edges.RemoteEvent),
				ParticipantsCount: len(event.Edges.Participants),
			})
		} else {
			eventsWithType = append(eventsWithType, dtos.EventWithTypeDTO{
				ID:                event.ID,
				StartDate:         event.StartDate,
				EndDate:           event.EndDate,
				IsPrivate:         event.IsPrivate,
				Title:             event.Title,
				Description:       event.Description,
				InvitationLink:    event.InvitationLink,
				Image:             event.Image,
				PhysicalEventDTO:  dtos.EntToPhysicalEventDTO(event.Edges.PhysicalEvent),
				ParticipantsCount: len(event.Edges.Participants),
			})
		}
	}

	return eventsWithType, nil
}

func (es *EventService) GetEventsByUser(userID string) ([]dtos.EventWithTypeDTO, error) {
	events, err := es.eventRepository.GetEventsByUser(userID)
	if err != nil {
		return nil, err
	}

	var eventsWithType []dtos.EventWithTypeDTO

	for _, event := range events {
		if event.Edges.RemoteEvent != nil {
			eventsWithType = append(eventsWithType, dtos.EventWithTypeDTO{
				ID:                event.ID,
				StartDate:         event.StartDate,
				EndDate:           event.EndDate,
				IsPrivate:         event.IsPrivate,
				Title:             event.Title,
				Description:       event.Description,
				InvitationLink:    event.InvitationLink,
				Image:             event.Image,
				RemoteEventDTO:    dtos.EntToRemoteEventDTO(event.Edges.RemoteEvent),
				ParticipantsCount: len(event.Edges.Participants),
			})
		} else {
			eventsWithType = append(eventsWithType, dtos.EventWithTypeDTO{
				ID:                event.ID,
				StartDate:         event.StartDate,
				EndDate:           event.EndDate,
				IsPrivate:         event.IsPrivate,
				Title:             event.Title,
				Description:       event.Description,
				InvitationLink:    event.InvitationLink,
				Image:             event.Image,
				PhysicalEventDTO:  dtos.EntToPhysicalEventDTO(event.Edges.PhysicalEvent),
				ParticipantsCount: len(event.Edges.Participants),
			})
		}
	}

	return eventsWithType, nil
}

func (es *EventService) GetEventWithDetails(eventID string) (dtos.EventWithDetailsDTO, error) {
	event, err := es.eventRepository.GetEvent(eventID)
	if err != nil {
		return dtos.EventWithDetailsDTO{}, err
	}

	participants, err := es.participantRepository.GetParticipantsByEvent(eventID)
	if err != nil {
		return dtos.EventWithDetailsDTO{}, err
	}

	eventDetails := dtos.EventWithDetailsDTO{
		ID:                event.ID,
		StartDate:         event.StartDate,
		EndDate:           event.EndDate,
		IsPrivate:         event.IsPrivate,
		Title:             event.Title,
		Description:       event.Description,
		InvitationLink:    event.InvitationLink,
		Image:             event.Image,
		Participants:      dtos.ConvertParticipantsWithUser(participants),
		ParticipantsCount: len(participants),
		EventDocuments:    dtos.EntToEventDocumentDTO(event.Edges.EventDocuments),
	}

	if event.Edges.RemoteEvent != nil {
		eventDetails.RemoteEventDTO = dtos.EntToRemoteEventDTO(event.Edges.RemoteEvent)
	} else {
		eventDetails.PhysicalEventDTO = dtos.EntToPhysicalEventDTO(event.Edges.PhysicalEvent)
	}

	return eventDetails, nil
}

func (es *EventService) GetParticipantPending(eventID string) ([]dtos.PendingParticipantDTO, error) {

	participants, err := es.participantRepository.GetPendingParticipantsByEvent(eventID)

	if err != nil {
		return nil, err
	}

	pendingParticipantsDTO := []dtos.PendingParticipantDTO{}

	for _, participant := range participants {
		pendingParticipantsDTO = append(pendingParticipantsDTO, *dtos.EntToPendingParticipantDTO(participant))
	}

	return pendingParticipantsDTO, nil
}
