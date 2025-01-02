package services

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/repositories"
	"edumeet/structures"
	"edumeet/utils"
	"errors"
	"fmt"
	"sort"
	"strconv"
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

func (es *EventService) GetFilteredEvents(filters structures.EventFilters) ([]dtos.EventWithTypeDTO, error) {
	events, err := es.eventRepository.GetEventsWithFilters(filters)
	if err != nil {
		return nil, err
	}

	var filteredEvents []*ent.Event

	if filters.Type != "remote" && filters.Distance != "" && filters.Longitude != "" && filters.Latitude != "" {

		dist, err := strconv.ParseFloat(filters.Distance, 64)
		if err != nil {
			return nil, fmt.Errorf("invalid distance value: %v", err)
		}

		longitude, err := strconv.ParseFloat(filters.Longitude, 64)
		if err != nil {
			return nil, fmt.Errorf("invalid longitude value: %v", err)
		}

		latitude, err := strconv.ParseFloat(filters.Latitude, 64)
		if err != nil {
			return nil, fmt.Errorf("invalid latitude value: %v", err)
		}

		for _, event := range events {
			if filters.Type == "all" && event.Edges.RemoteEvent != nil {
				filteredEvents = append(filteredEvents, event)
				continue
			}
			if event.Edges.PhysicalEvent != nil {
				eventLng := event.Edges.PhysicalEvent.Lng
				eventLat := event.Edges.PhysicalEvent.Lat

				if utils.CalculateDistance(latitude, longitude, eventLat, eventLng) <= dist {
					filteredEvents = append(filteredEvents, event)
				}
			}
		}
	} else {
		filteredEvents = events
	}

	eventsWithType := make([]dtos.EventWithTypeDTO, 0)
	for _, event := range filteredEvents {
		if event.Edges.RemoteEvent != nil {
			eventsWithType = append(eventsWithType, dtos.EventWithTypeDTO{
				ID:                event.ID,
				StartDate:         event.StartDate,
				EndDate:           event.EndDate,
				IsPrivate:         event.IsPrivate,
				Title:             event.Title,
				Description:       event.Description,
				Image:             event.Image,
				RemoteEventDTO:    dtos.EntToRemoteEventDTO(event.Edges.RemoteEvent),
				ParticipantsCount: len(event.Edges.Participants),
				CreatedBy:         event.CreatedBy,
			})
		} else {
			eventsWithType = append(eventsWithType, dtos.EventWithTypeDTO{
				ID:                event.ID,
				StartDate:         event.StartDate,
				EndDate:           event.EndDate,
				IsPrivate:         event.IsPrivate,
				Title:             event.Title,
				Description:       event.Description,
				Image:             event.Image,
				PhysicalEventDTO:  dtos.EntToPhysicalEventDTO(event.Edges.PhysicalEvent),
				ParticipantsCount: len(event.Edges.Participants),
				CreatedBy:         event.CreatedBy,
			})
		}
	}

	sort.Slice(eventsWithType, func(i, j int) bool {
		return eventsWithType[i].StartDate.Before(eventsWithType[j].StartDate)
	})

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
				Image:             event.Image,
				RemoteEventDTO:    dtos.EntToRemoteEventDTO(event.Edges.RemoteEvent),
				ParticipantsCount: len(event.Edges.Participants),
				CreatedBy:         event.CreatedBy,
			})
		} else {
			eventsWithType = append(eventsWithType, dtos.EventWithTypeDTO{
				ID:                event.ID,
				StartDate:         event.StartDate,
				EndDate:           event.EndDate,
				IsPrivate:         event.IsPrivate,
				Title:             event.Title,
				Description:       event.Description,
				Image:             event.Image,
				PhysicalEventDTO:  dtos.EntToPhysicalEventDTO(event.Edges.PhysicalEvent),
				ParticipantsCount: len(event.Edges.Participants),
				CreatedBy:         event.CreatedBy,
			})
		}
	}

	return eventsWithType, nil
}

func (es *EventService) GetEventsCreatedByUser(userID string) ([]dtos.EventWithTypeDTO, error) {
	events, err := es.eventRepository.GetEventsCreatedByUser(userID)
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
				Image:             event.Image,
				RemoteEventDTO:    dtos.EntToRemoteEventDTO(event.Edges.RemoteEvent),
				ParticipantsCount: len(event.Edges.Participants),
				CreatedBy:         event.CreatedBy,
			})
		} else {
			eventsWithType = append(eventsWithType, dtos.EventWithTypeDTO{
				ID:                event.ID,
				StartDate:         event.StartDate,
				EndDate:           event.EndDate,
				IsPrivate:         event.IsPrivate,
				Title:             event.Title,
				Description:       event.Description,
				Image:             event.Image,
				PhysicalEventDTO:  dtos.EntToPhysicalEventDTO(event.Edges.PhysicalEvent),
				ParticipantsCount: len(event.Edges.Participants),
				CreatedBy:         event.CreatedBy,
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
		Image:             event.Image,
		Participants:      dtos.ConvertParticipantsWithUser(participants),
		ParticipantsCount: len(participants),
		EventDocuments:    dtos.EntToEventDocumentDTO(event.Edges.EventDocuments),
		CreatedBy:         event.CreatedBy,
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

func (es *EventService) UpdateEventSubjects(ctx context.Context, eventID string, subjects []string) error {
	_, err := es.eventRepository.UpdateEventSubjects(ctx, eventID, subjects)
	if err != nil {
		return err
	}
	return nil
}
func (es *EventService) JoinEventByCode(eventCode string, userID string) error {

	event, err := es.eventRepository.GetEventByCode(eventCode)

	if err != nil {
		return err
	}

	if event.Edges.Participants != nil {
		for _, participant := range event.Edges.Participants {
			if participant.Edges.User.ID == userID {
				return errors.New("user already joined the event")
			}
		}
	}

	_, err = es.participantRepository.CreateParticipant(userID, event.ID, "accepted")

	if err != nil {
		return err
	}

	return nil
}

func (es *EventService) GetEventCode(eventId string) (*dtos.EventCodeDTO, error) {
	event, err := es.eventRepository.GetEventCode(eventId)
	if err != nil {
		return nil, err
	}
	return dtos.EntToEventCodeDTO(event), nil
}

func (es *EventService) UpdateEventAdmin(ctx context.Context, eventID string, updateEventAdminDTO dtos.UpdateEventAdminDTO) error {
	_, err := es.eventRepository.UpdateEventAdmin(ctx, updateEventAdminDTO, eventID)
	if err != nil {
		return err
	}

	return nil
}
