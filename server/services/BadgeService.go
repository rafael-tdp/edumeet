package services

import (
	"edumeet/dtos"
	"edumeet/repositories"

	"github.com/sirupsen/logrus"
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
		logrus.Error("Error BadgeService function GetBadgeById: ", err)
		return dtos.BadgeDTO{}, err
	}

	if err != nil {
		logrus.Error("Error BadgeService function GetBadgeById: ", err)
		return dtos.BadgeDTO{}, err
	}

	badgeDTO := dtos.BadgeEntToDTO(badge)
	logrus.Info("BadgeService function GetBadgeById: ", badgeDTO)
	return badgeDTO, nil
}

func (r *BadgeService) DeleteBadge(badgeID string) error {
	err := r.badgeRepo.DeleteBadge(badgeID)
	if err != nil {
		logrus.Error("Error BadgeService function DeleteBadge: ", err)
		return err
	}

	return nil
}

func (r *BadgeService) CreateBadge(badgeDTO dtos.BadgeDTO) (dtos.BadgeDTO, error) {
	badge, err := r.badgeRepo.CreateBadge(badgeDTO)
	if err != nil {
		logrus.Error("Error BadgeService function CreateBadge: ", err)
		return dtos.BadgeDTO{}, err
	}
	logrus.Info("BadgeService function CreateBadge: ", badge)
	return dtos.BadgeEntToDTO(badge), nil
}

func (r *BadgeService) GetBadges() ([]dtos.BadgeDTO, error) {
	badges, err := r.badgeRepo.GetBadges()
	if err != nil {
		logrus.Error("Error BadgeService function GetBadges: ", err)
		return nil, err
	}

	var badgesDTO []dtos.BadgeDTO
	for _, badge := range badges {
		if err != nil {
			logrus.Error("Error BadgeService function GetBadges: ", err)
			return nil, err
		}
		badgeDTO := dtos.BadgeEntToDTO(badge)
		badgesDTO = append(badgesDTO, badgeDTO)
	}
	logrus.Info("BadgeService function GetBadges: ", badgesDTO)
	return badgesDTO, nil
}

func (r *BadgeService) UpdateBadge(badgeId string, badgeDTO dtos.BadgeDTO) (dtos.BadgeDTO, error) {
	badge, err := r.badgeRepo.UpdateBadge(badgeId, badgeDTO)
	if err != nil {
		logrus.Error("Error BadgeService function UpdateBadge: ", err)
		return dtos.BadgeDTO{}, err
	}
	logrus.Info("BadgeService function UpdateBadge: ", badge)
	return dtos.BadgeEntToDTO(badge), nil
}
