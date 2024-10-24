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
		User: dtos.UserDTO{
			ID:   reporting.Edges.User.ID,
			Role: reporting.Edges.User.Role,
		},
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
