package repositories

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/ent/subject"
	"errors"
	"fmt"
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
		return nil, errors.New("error updating subject")
	}
	return subject, nil
}

func (sr *SubjectRepository) AddUserToSubject(subjectID string, userID string) (*ent.Subject, error) {
	// Récupérer le subject existant
	subject, err := sr.client.Subject.Get(context.Background(), subjectID)
	if err != nil {
		fmt.Print(err)
		return nil, fmt.Errorf("error fetching subject with ID %s: %v", subjectID, err)
	}

	// Ajouter l'utilisateur au subject
	updatedSubject, err := subject.Update().AddUserIDs(userID).Save(context.Background())
	if err != nil {
		fmt.Print(userID)
		fmt.Print(err)
		return nil, errors.New("error adding user to subject")
	}

	return updatedSubject, nil
}

func (sr *SubjectRepository) RemoveUserFromSubject(subjectID string, userID string) (*ent.Subject, error) {
	subject, err := sr.client.Subject.Get(context.Background(), subjectID)
	if err != nil {
		return nil, fmt.Errorf("error fetching subject with ID %s: %v", subjectID, err)
	}

	updatedSubject, err := subject.Update().RemoveUserIDs(userID).Save(context.Background())
	if err != nil {
		return nil, fmt.Errorf("error removing user %s from subject %s: %v", userID, subjectID, err)
	}

	return updatedSubject, nil
}
