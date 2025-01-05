package services

import (
	"edumeet/dtos"
	"edumeet/enums"
	"edumeet/repositories"
	"errors"
	"time"

	"github.com/sirupsen/logrus"
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
		logrus.Error("Error ParticipantService.RequestParticipant: ", errEvent)
		return errEvent
	}

	if event.StartDate.Before(time.Now()) {
		logrus.Warn("Error ParticipantService.RequestParticipant: Event is already started")
		return errors.New("Event is already started")
	}

	//check if participant is already in the event
	_, errParticipant := ps.participantRepository.GetParticipantByEventAndUser(eventID, userID)

	if errParticipant == nil || (event.CreatedBy != nil && userID == *event.CreatedBy) {
		logrus.Warn("Error ParticipantService.RequestParticipant: participant already in the event")
		return errors.New("participant already in the event")
	}

	status := string(enums.ParticipantAccepted)
	if event.IsPrivate {
		status = string(enums.ParticipantPending)
	}

	_, err := ps.participantRepository.CreateParticipant(userID, eventID, status)

	if err != nil {
		logrus.Error("Error ParticipantService.RequestParticipant: ", err)
		return err
	}

	return nil
}

func (ps *ParticipantService) ProcessParticipant(participant dtos.ParticipantDetailDTO, statut string) error {

	if participant.Status == string(enums.ParticipantRejected) {
		logrus.Warn("Error ParticipantService.ProcessParticipant: participant already rejected")
		return errors.New("participant already rejected")
	}

	if statut != string(enums.ParticipantAccepted) && statut != string(enums.ParticipantRejected) {
		logrus.Warn("Error ParticipantService.ProcessParticipant: invalid statut")
		return errors.New("invalid statut")
	}

	_, err := ps.participantRepository.UpdateParticipantStatut(participant.ID, statut)

	if err != nil {
		logrus.Error("Error ParticipantService.ProcessParticipant: ", err)
		return err
	}

	return nil
}

func (ps *ParticipantService) GetParticipantDetail(participantID string) (*dtos.ParticipantDetailDTO, error) {

	participant, err := ps.participantRepository.GetParticipantDetail(participantID)

	if err != nil {
		logrus.Error("Error ParticipantService.GetParticipantDetail: ", err)
		return nil, err
	}

	logrus.Info("ParticipantService.GetParticipantDetail: Participant found")
	return dtos.EntToParticipantDetailDTO(participant), nil
}

func (ps *ParticipantService) LeaveEventParticipation(participantID string) error {
	return ps.participantRepository.DeleteParticipant(participantID)
}
