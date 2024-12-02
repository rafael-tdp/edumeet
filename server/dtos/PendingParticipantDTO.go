package dtos

import "edumeet/ent"

type PendingParticipantDTO struct {
	ID   string  `json:"id"`
	User UserDTO `json:"user"`
}

func EntToPendingParticipantDTO(pendingParticipant *ent.Participant) *PendingParticipantDTO {
	return &PendingParticipantDTO{
		ID:   pendingParticipant.ID,
		User: *EntToUserDTO(pendingParticipant.Edges.User),
	}
}
