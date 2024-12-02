package services

import (
	"edumeet/dtos"
	"edumeet/enums"
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

	status := string(enums.ParticipantAccepted)
	if event.IsPrivate {
		status = string(enums.ParticipantPending)
	}

	_, err := ps.participantRepository.CreateParticipant(userID, eventID, status)

	if err != nil {
		return err
	}

	return nil
}

func (ps *ParticipantService) ProcessParticipant(participant dtos.ParticipantDTO, statut string) error {

	if participant.Status != string(enums.ParticipantPending) {
		return errors.New("le participant a déjà été traité")
	}

	_, err := ps.participantRepository.UpdateParticipantStatut(participant.ID, statut)

	if err != nil {
		return err
	}

	return nil
}

func (ps *ParticipantService) GetParticipantDetail(participantID string) (*dtos.ParticipantDetailDTO, error) {

	participant, err := ps.participantRepository.GetParticipantDetail(participantID)

	if err != nil {
		return nil, err
	}

	return dtos.EntToParticipantDetailDTO(participant), nil
}
