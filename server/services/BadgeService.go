package services

import (
	"context"
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

	badgeDTO := dtos.BadgeEntToDTO(badge)

	return badgeDTO, nil
}

func (r *BadgeService) DeleteBadge(badgeID string) error {
	err := r.badgeRepo.DeleteBadge(badgeID)
	if err != nil {
		return err
	}

	return nil
}

func (r *BadgeService) CreateBadge(ctx context.Context, badgeDTO dtos.BadgeDTO) (dtos.BadgeDTO, error) {
	badge, err := r.badgeRepo.CreateBadge(ctx, badgeDTO)
	if err != nil {
		return dtos.BadgeDTO{}, err
	}

	return dtos.BadgeEntToDTO(badge), nil
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
		badgeDTO := dtos.BadgeEntToDTO(badge)
		badgesDTO = append(badgesDTO, badgeDTO)
	}

	return badgesDTO, nil
}

func (r *BadgeService) UpdateBadge(ctx context.Context, badgeId string, badgeDTO dtos.BadgeDTO) (dtos.BadgeDTO, error) {
	badge, err := r.badgeRepo.UpdateBadge(ctx, badgeId, badgeDTO)
	if err != nil {
		return dtos.BadgeDTO{}, err
	}

	return dtos.BadgeEntToDTO(badge), nil
}
