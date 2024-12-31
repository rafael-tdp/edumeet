package repositories

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/ent/subject"
	"errors"
)

type SubjectRepository struct {
	client *ent.Client
}

func NewSubjectRepository(client *ent.Client) *SubjectRepository {
	return &SubjectRepository{
		client: client,
	}
}

func (sr *SubjectRepository) GetById(subjectID string) (*ent.Subject, error) {
	subject, err := sr.client.Subject.Query().Where(subject.IDEQ(subjectID)).Only(context.Background())
	if err != nil {
		return nil, errors.New("user not found")
	}
	return subject, nil
}

func (sr *SubjectRepository) Create(subjectDTO dtos.SubjectDTO) (*ent.Subject, error) {
	subject, err := sr.client.Subject.Create().
		SetName(subjectDTO.Name).
		Save(context.Background())
	if err != nil {
		return nil, errors.New("error creating subject")
	}
	return subject, nil
}

func (sr *SubjectRepository) Delete(subjectID string) error {
	err := sr.client.Subject.DeleteOneID(subjectID).Exec(context.Background())
	if err != nil {
		return errors.New("error deleting subject")
	}
	return nil
}

func (sr *SubjectRepository) GetSubjects() ([]*ent.Subject, error) {
	subjects, err := sr.client.Subject.Query().All(context.Background())
	if err != nil {
		return nil, errors.New("error getting subjects")
	}
	return subjects, nil
}

func (sr *SubjectRepository) Update(subjectID string, subjectDTO dtos.SubjectDTO) (*ent.Subject, error) {
	subject, err := sr.client.Subject.UpdateOneID(subjectID).
		SetName(subjectDTO.Name).
		Save(context.Background())
	if err != nil {
		return nil, err
	}
	return subject, nil
}
