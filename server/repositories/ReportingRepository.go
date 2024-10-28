package repositories

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/ent/event"
	"edumeet/ent/message"
	"edumeet/ent/reporting"
	"edumeet/ent/user"
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

func (r *ReportingRepository) CreateReporting(reportingDTO dtos.ReportingDTO) error {

	userReporter, err := r.client.User.Query().Where(user.IDEQ(reportingDTO.UserID)).Only(context.Background())
	if err != nil {
		return errors.New("user not found")
	}

	switch reportingDTO.Type {
	case "USER":
		_, err = r.client.User.Query().Where(user.IDEQ(reportingDTO.EntityID)).Only(context.Background())
		break
	case "MESSAGE":
		_, err = r.client.Message.Query().Where(message.IDEQ(reportingDTO.EntityID)).Only(context.Background())
		break
	case "EVENT":
		_, err = r.client.Event.Query().Where(event.IDEQ(reportingDTO.EntityID)).Only(context.Background())
		break
	default:
		return errors.New("invalid entity type")
	}

	if err != nil {
		return errors.New("entity not found")
	}

	_, err = r.client.Reporting.Create().SetReason(reportingDTO.Reason).SetType(reportingDTO.Type).SetUser(userReporter).SetEntityID(reportingDTO.EntityID).Save(context.Background())
	if err != nil {
		return errors.New("error creating reporting")
	}

	return nil
}

func (r *ReportingRepository) GetEntity(entityType string, entityID string) (interface{}, error) {
	switch entityType {
	case "USER":
		user, err := r.client.User.Query().Where(user.IDEQ(entityID)).Only(context.Background())
		if err != nil {
			return nil, errors.New("user not found")
		}
		return user, nil
	case "MESSAGE":
		message, err := r.client.Message.Query().Where(message.IDEQ(entityID)).Only(context.Background())
		if err != nil {
			return nil, errors.New("message not found")
		}
		return message, nil
	case "EVENT":
		event, err := r.client.Event.Query().Where(event.IDEQ(entityID)).Only(context.Background())
		if err != nil {
			return nil, errors.New("event not found")
		}
		return event, nil
	default:
		return nil, errors.New("invalid entity type")
	}
}
