package services

import (
	"edumeet/repositories"
	"errors"
	"time"
)

type ParticipantService struct {
	participantRepository *repositories.ParticipantRepository
	eventRepository       *repositories.EventRepository
}

func NewParticipantService(participantRepository *repositories.ParticipantRepository, eventRepository *repositories.EventRepository) *ParticipantService {
	return &ParticipantService{
		participantRepository: participantRepository,
		eventRepository:       eventRepository,
	}
}

func (ps *ParticipantService) RequestParticipant(eventID string, userID string) error {

	event, errEvent := ps.eventRepository.GetEvent(eventID)

	if errEvent != nil {
		return errEvent
	}

	if event.StartDate.Before(time.Now()) {
		return errors.New("Event is already started")
	}

	//check if participant is already in the event
	_, errParticipant := ps.participantRepository.GetParticipantByEventAndUser(eventID, userID)

	if errParticipant == nil || userID == *event.CreatedBy {
		return errors.New("le participant est déjà dans l'événement")
	}

	status := "accepted"
	if event.IsPrivate {
		status = "pending"
	}

	_, err := ps.participantRepository.CreateParticipant(userID, eventID, status)

	if err != nil {
		return err
	}

	return nil
}

func (ps *ParticipantService) ProcessParticipant(participantID string, statut string) error {

	participant, err := ps.participantRepository.GetParticipant(participantID)

	if err != nil {
		return err
	}

	if participant.Status == "accepted" {
		return errors.New("Participant is already accepted")
	}

	_, err = ps.participantRepository.UpdateParticipantStatut(participantID, statut)

	if err != nil {
		return err
	}

	return nil
}
