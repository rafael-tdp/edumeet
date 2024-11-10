package services

import (
	"edumeet/dtos"
	"edumeet/repositories"
)

type EventService struct {
	eventRepository *repositories.EventRepository
}

func NewEventService(eventRepository *repositories.EventRepository) *EventService {
	return &EventService{
		eventRepository: eventRepository,
	}
}

func (es *EventService) CreateRemoteEvent(remoteEventDTO dtos.RemoteEventDTO) (*dtos.RemoteEventDTO, error) {
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
