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

	remoteEvent, err := es.eventRepository.CreateRemoteEvent(remoteEvent)

	if err != nil {
		return nil, err
	}

	return remoteEvent, nil
}
