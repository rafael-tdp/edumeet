package repositories

import (
	"edumeet/ent"
)

type ParticipantRepository struct {
	client *ent.Client
}

func NewParticipantRepository(client *ent.Client) *ParticipantRepository {
	return &ParticipantRepository{
		client: client,
	}
}
