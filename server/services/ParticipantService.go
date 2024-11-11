package services

import (
	"edumeet/repositories"
)

type ParticipantService struct {
	participantRepository *repositories.ParticipantRepository
}

func NewParticipantService(participantRepository *repositories.ParticipantRepository) *ParticipantService {
	return &ParticipantService{
		participantRepository: participantRepository,
	}
}
