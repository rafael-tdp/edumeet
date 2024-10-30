package services

import (
	"edumeet/dtos"
	"edumeet/repositories"
)

type BadgeService struct {
	badgeRepo *repositories.BadgeRepository
}

func NewBadgeService(badgeRepo *repositories.BadgeRepository) *BadgeService {
	return &BadgeService{
		badgeRepo: badgeRepo,
	}
}

func (r *BadgeService) GetBadgeById(badgeID string) (dtos.BadgeDTO, error) {
	badge, err := r.badgeRepo.GetBadgeById(badgeID)
	if err != nil {
		return dtos.BadgeDTO{}, err
	}

	if err != nil {
		return dtos.BadgeDTO{}, err
	}

	badgeDTO := dtos.BadgeDTO{
		ID:                 badge.ID,
		Name:               badge.Name,
		Type:               badge.Type,
		NbRequirementEvent: badge.NbRequirementEvent,
		Svg:                badge.Svg,
	}

	return badgeDTO, nil
}

func (r *BadgeService) DeleteBadge(badgeID string) error {
	err := r.badgeRepo.DeleteBadge(badgeID)
	if err != nil {
		return err
	}

	return nil
}

func (r *BadgeService) CreateBadge(badgeDTO dtos.BadgeDTO) (dtos.BadgeDTO, error) {
	badge, err := r.badgeRepo.CreateBadge(badgeDTO)
	if err != nil {
		return dtos.BadgeDTO{}, err
	}

	return dtos.BadgeDTO{
		ID:                 badge.ID,
		Name:               badge.Name,
		Type:               badge.Type,
		NbRequirementEvent: badge.NbRequirementEvent,
		Svg:                badge.Svg,
	}, nil
}

func (r *BadgeService) GetBadges() ([]dtos.BadgeDTO, error) {
	badges, err := r.badgeRepo.GetBadges()
	if err != nil {
		return nil, err
	}

	var badgesDTO []dtos.BadgeDTO
	for _, badge := range badges {
		if err != nil {
			return nil, err
		}
		badgeDTO := dtos.BadgeDTO{
			ID:                 badge.ID,
			Name:               badge.Name,
			Type:               badge.Type,
			NbRequirementEvent: badge.NbRequirementEvent,
			Svg:                badge.Svg,
		}
		badgesDTO = append(badgesDTO, badgeDTO)
	}

	return badgesDTO, nil
}

func (r *BadgeService) UpdateBadge(badgeId string, badgeDTO dtos.BadgeDTO) (dtos.BadgeDTO, error) {
	badge, err := r.badgeRepo.UpdateBadge(badgeId, badgeDTO)
	if err != nil {
		return dtos.BadgeDTO{}, err
	}

	return dtos.BadgeDTO{
		ID:                 badge.ID,
		Name:               badge.Name,
		Type:               badge.Type,
		NbRequirementEvent: badge.NbRequirementEvent,
		Svg:                badge.Svg,
	}, nil
}
