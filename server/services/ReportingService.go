package services

import (
	"context"
	"edumeet/dtos"
	"edumeet/repositories"

	"github.com/sirupsen/logrus"
)

type ReportingService struct {
	reportingRepo *repositories.ReportingRepository
}

func NewReportingService(reportingRepo *repositories.ReportingRepository) *ReportingService {
	return &ReportingService{
		reportingRepo: reportingRepo,
	}
}

func (r *ReportingService) GetReportingById(reportingID string) (dtos.ReportingDTO, error) {
	reporting, err := r.reportingRepo.GetReportingById(reportingID)
	if err != nil {
		logrus.Error("Error ReportingService.GetReportingById: ", err)
		return dtos.ReportingDTO{}, err
	}

	entity, err := r.reportingRepo.GetEntity(reporting.Type, reporting.EntityID)
	if err != nil {
		logrus.Error("Error ReportingService.GetReportingById: ", err)
		return dtos.ReportingDTO{}, err
	}
	reportingDTO := dtos.ReportingEntToDTO(reporting, entity)

	return reportingDTO, nil
}

func (r *ReportingService) DeleteReporting(reportingID string) error {
	err := r.reportingRepo.DeleteReporting(reportingID)
	if err != nil {
		logrus.Error("Error ReportingService.DeleteReporting: ", err)
		return err
	}

	return nil
}

func (r *ReportingService) CreateReporting(ctx context.Context, reportingDTO dtos.ReportingDTO) (dtos.ReportingDTO, error) {
	reporting, err := r.reportingRepo.CreateReporting(ctx, reportingDTO)
	if err != nil {
		logrus.Error("Error ReportingService.CreateReporting: ", err)
		return dtos.ReportingDTO{}, err
	}

	entity, err := r.reportingRepo.GetEntity(reporting.Type, reporting.EntityID)
	if err != nil {
		logrus.Error("Error ReportingService.CreateReporting: ", err)
		return dtos.ReportingDTO{}, err
	}
	reportingDTO = dtos.ReportingEntToDTO(reporting, entity)

	logrus.Info("ReportingService.CreateReporting: Reporting created successfully")
	return reportingDTO, nil
}
