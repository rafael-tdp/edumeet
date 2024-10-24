package repositories

import (
	"context"
	"edumeet/ent"
	"edumeet/ent/reporting"
	"errors"
)

type ReportingRepository struct {
	client *ent.Client
}

func NewReportingRepository(client *ent.Client) *ReportingRepository {
	return &ReportingRepository{
		client: client,
	}
}

func (r *ReportingRepository) GetReportingById(reportingID string) (*ent.Reporting, error) {

	reporting, err := r.client.Reporting.Query().Where(reporting.IDEQ(reportingID)).WithUser().Only(context.Background())
	if err != nil {
		return nil, errors.New("reporting not found")
	}

	return reporting, nil
}

func (r *ReportingRepository) DeleteReporting(reportingID string) error {

	reporting, err := r.client.Reporting.Query().Where(reporting.IDEQ(reportingID)).Only(context.Background())
	if err != nil {
		return errors.New("reporting not found")
	}

	err = r.client.Reporting.DeleteOne(reporting).Exec(context.Background())
	if err != nil {
		return errors.New("error deleting reporting")
	}

	return nil
}
