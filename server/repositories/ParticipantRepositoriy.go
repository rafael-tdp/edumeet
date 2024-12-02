package repositories

import (
	"context"
	"edumeet/ent"
	"edumeet/ent/event"
	"edumeet/ent/participant"
	"edumeet/ent/user"
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

func (pr *ParticipantRepository) GetParticipant(participantId string) (*ent.Participant, error) {
	participant, err := pr.client.Participant.
		Query().
		Where(participant.IDEQ(participantId)).
		WithEvent().
		WithUser().
		First(context.Background())

	if err != nil {
		return nil, err
	}
	return participant, nil
}

func (pr *ParticipantRepository) UpdateParticipantStatut(participantId string, status string) (*ent.Participant, error) {
	participant, err := pr.client.Participant.UpdateOneID(participantId).
		SetStatus(status).
		Save(context.Background())
	if err != nil {
		return nil, err
	}

	return participant, nil
}

func (pr *ParticipantRepository) GetParticipantByEventAndUser(eventId string, userId string) (*ent.Participant, error) {
	participant, err := pr.client.Participant.Query().
		Where(participant.HasEventWith(event.IDEQ(eventId))).
		Where(participant.HasUserWith(user.IDEQ(userId))).
		First(context.Background())

	if err != nil {
		return nil, err
	}

	return participant, nil
}

func (pr *ParticipantRepository) GetParticipantsByEvent(eventId string) ([]*ent.Participant, error) {
	participants, err := pr.client.Participant.Query().
		Where(participant.HasEventWith(event.IDEQ(eventId))).
		WithUser().
		All(context.Background())
	if err != nil {
		return nil, err
	}

	return participants, nil
}
