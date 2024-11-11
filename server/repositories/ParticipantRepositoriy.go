package repositories

import (
	"context"
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

func (pr *ParticipantRepository) CreateParticipant(userId string, eventId string, status string) (*ent.Participant, error) {
	createdParticipant, err := pr.client.Participant.Create().
		SetStatus(status).
		SetEventID(eventId).
		SetUserID(userId).
		Save(context.Background())
	if err != nil {
		return nil, err
	}

	return createdParticipant, nil
}
