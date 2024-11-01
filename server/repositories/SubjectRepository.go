package repositories

import (
	"context"
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

func (sr *SubjectRepository) Create(subject *ent.Subject) (*ent.Subject, error) {
	subject, err := sr.client.Subject.Create().
		SetName(subject.Name).
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
