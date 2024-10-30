package repositories

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/ent/badge"
	"errors"
)

type BadgeRepository struct {
	client *ent.Client
}

func NewBadgeRepository(client *ent.Client) *BadgeRepository {
	return &BadgeRepository{
		client: client,
	}
}

func (r *BadgeRepository) GetBadgeById(badgeID string) (*ent.Badge, error) {

	badge, err := r.client.Badge.Query().Where(badge.IDEQ(badgeID)).Only(context.Background())
	if err != nil {
		return nil, errors.New("badge not found")
	}

	return badge, nil
}

func (r *BadgeRepository) GetBadges() ([]*ent.Badge, error) {

	badges, err := r.client.Badge.Query().All(context.Background())
	if err != nil {
		return nil, errors.New("error getting badges")
	}

	return badges, nil
}

func (r *BadgeRepository) DeleteBadge(badgeID string) error {

	badge, err := r.client.Badge.Query().Where(badge.IDEQ(badgeID)).Only(context.Background())
	if err != nil {
		return errors.New("badge not found")
	}

	err = r.client.Badge.DeleteOne(badge).Exec(context.Background())
	if err != nil {
		return errors.New("error deleting badge")
	}

	return nil
}

func (r *BadgeRepository) CreateBadge(badgeDTO dtos.BadgeDTO) (*ent.Badge, error) {
	badge, err := r.client.Badge.Create().SetName(badgeDTO.Name).SetType(badgeDTO.Type).SetNbRequirementEvent(badgeDTO.NbRequirementEvent).SetSvg(badgeDTO.Svg).Save(context.Background())
	if err != nil {
		return nil, errors.New("error creating badge")
	}

	return badge, nil
}

func (r *BadgeRepository) UpdateBadge(badgeId string, badgeDTO dtos.BadgeDTO) (*ent.Badge, error) {
	badge, err := r.client.Badge.Query().Where(badge.IDEQ(badgeId)).Only(context.Background())
	if err != nil {
		return nil, errors.New("badge not found")
	}

	badge, err = badge.Update().SetName(badgeDTO.Name).SetType(badgeDTO.Type).SetNbRequirementEvent(badgeDTO.NbRequirementEvent).SetSvg(badgeDTO.Svg).Save(context.Background())
	if err != nil {
		return nil, errors.New("error updating badge")
	}

	return badge, nil
}
