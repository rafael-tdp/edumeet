package services

import (
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

func (es *EventService) CreateRemoteEvent(remoteEventDTO dtos.RemoteEventDTO, userId string) (*dtos.RemoteEventDTO, error) {
	event, err := remoteEventDTO.ToEntEvent()
	if err != nil {
		return nil, err
	}

	remoteEvent, err := remoteEventDTO.ToEntRemoteEvent()
	if err != nil {
		return nil, err
	}

	createdEvent, err := es.eventRepository.CreateEvent(event)
	if err != nil {
		return nil, err
	}

	createdRemoteEvent, err := es.eventRepository.CreateRemoteEvent(createdEvent, remoteEvent)
	if err != nil {
		return nil, err
	}

	_, err = es.participantRepository.CreateParticipant(userId, createdEvent.ID, "host")

	if err != nil {
		return nil, err
	}

	remote := dtos.EntToRemoteEventDTO(createdRemoteEvent, createdEvent)

	return remote, nil
}

func (es *EventService) DeleteEvent(eventID string) error {
	err := es.eventRepository.DeleteEvent(eventID)
	if err != nil {
		return err
	}

	return nil
}

func (es *EventService) GetRemoteEvent(eventID string) (*dtos.RemoteEventDTO, error) {
	remoteEvent, err := es.eventRepository.GetRemoteEvent(eventID)
	if err != nil {
		return nil, err
	}

	event, err := es.eventRepository.GetEvent(remoteEvent.Edges.Event.ID)
	if err != nil {
		return nil, err
	}

	remote := dtos.EntToRemoteEventDTO(remoteEvent, event)

	return remote, nil
}

func (es *EventService) UpdateRemoteEvent(eventID string, remoteEventDTO dtos.RemoteEventDTO) (*dtos.RemoteEventDTO, error) {

	currentEvent, err := es.eventRepository.GetRemoteEvent(eventID)

	if err != nil {
		return nil, err
	}

	event, err := remoteEventDTO.ToEntEvent()
	if err != nil {
		return nil, err
	}

	remoteEvent, err := remoteEventDTO.ToEntRemoteEvent()
	if err != nil {
		return nil, err
	}

	updatedRemoteEvent, err := es.eventRepository.UpdateRemoteEvent(eventID, remoteEvent)
	if err != nil {
		return nil, err
	}

	updatedEvent, err := es.eventRepository.UpdateEvent(currentEvent.Edges.Event.ID, event)
	if err != nil {
		return nil, err
	}

	remote := dtos.EntToRemoteEventDTO(updatedRemoteEvent, updatedEvent)

	return remote, nil
}
