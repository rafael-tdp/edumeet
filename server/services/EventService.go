package services

import "edumeet/repositories"

type EventService struct {
	eventRepository *repositories.EventRepository
}

func NeweEventService(eventRepository *repositories.EventRepository) *EventService {
	return &EventService{
		eventRepository: eventRepository,
	}
}
