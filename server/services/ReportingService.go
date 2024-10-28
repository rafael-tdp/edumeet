package services

import (
	"edumeet/dtos"
	"edumeet/repositories"
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
		return dtos.ReportingDTO{}, err
	}

	reportingDTO := dtos.ReportingDTO{
		ID:       reporting.ID,
		Reason:   reporting.Reason,
		Type:     reporting.Type,
		EntityID: reporting.EntityID,
		UserID:   reporting.Edges.User.ID,
	}

	return reportingDTO, nil
}

func (r *ReportingService) DeleteReporting(reportingID string) error {
	err := r.reportingRepo.DeleteReporting(reportingID)
	if err != nil {
		return err
	}

	return nil
}

func (r *ReportingService) CreateReporting(reportingDTO dtos.ReportingDTO) (dtos.ReportingDTO, error) {
	err := r.reportingRepo.CreateReporting(reportingDTO)
	if err != nil {
		return dtos.ReportingDTO{}, err
	}

	return reportingDTO, nil
}
