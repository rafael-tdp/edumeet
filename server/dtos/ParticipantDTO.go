package dtos

import (
	"edumeet/ent"
	"time"
)

type ParticipantDTO struct {
	ID          string    `json:"id"`
	Status      string    `json:"status"`
	RequestedAt time.Time `json:"requested_at"`
	JoinedAt    time.Time `json:"joined_at,omitempty"`
	User        UserDTO   `json:"user"`
	Event       EventDTO  `json:"event"`
}

type ParticipantWithUserDTO struct {
	ID          string    `json:"id"`
	Status      string    `json:"status"`
	RequestedAt time.Time `json:"requested_at"`
	JoinedAt    time.Time `json:"joined_at,omitempty"`
	User        UserDTO   `json:"user"`
}

func EntToParticipantDTO(ent *ent.Participant) *ParticipantDTO {
	return &ParticipantDTO{
		ID:          ent.ID,
		Status:      ent.Status,
		RequestedAt: ent.RequestedAt,
		JoinedAt:    ent.JoinedAt,
		User:        *EntToUserDTO(ent.Edges.User),
		Event:       *EntToEventDTO(ent.Edges.Event),
	}
}

func EntToParticipantWithUserDTO(ent *ent.Participant) *ParticipantWithUserDTO {
	return &ParticipantWithUserDTO{
		ID:          ent.ID,
		Status:      ent.Status,
		RequestedAt: ent.RequestedAt,
		JoinedAt:    ent.JoinedAt,
		User:        *EntToUserDTO(ent.Edges.User),
	}
}

func ConvertParticipants(participants []*ent.Participant) []ParticipantDTO {
	var participantDTOs []ParticipantDTO
	for _, participant := range participants {
		participantDTOs = append(participantDTOs, *EntToParticipantDTO(participant))
	}
	return participantDTOs
}

func ConvertParticipantsWithUser(participants []*ent.Participant) []ParticipantWithUserDTO {
	var participantDTOs []ParticipantWithUserDTO
	for _, participant := range participants {
		participantDTOs = append(participantDTOs, *EntToParticipantWithUserDTO(participant))
	}
	return participantDTOs
}
