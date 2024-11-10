package dtos

import (
	"edumeet/ent"
	"errors"
)

type SubjectDTO struct {
	ID   string `json:"id"`
	Name string `json:"name"`
}

func ParseSubjectDTO(subject *ent.Subject) (*SubjectDTO, error) {
	if subject == nil {
		return nil, errors.New("subject is nil")
	}
	return &SubjectDTO{
		ID:   subject.ID,
		Name: subject.Name,
	}, nil
}

func ConvertSubjectDTOToEnt(subjectDTO *SubjectDTO) (*ent.Subject, error) {
	if subjectDTO == nil {
		return nil, errors.New("subjectDTO is nil")
	}
	return &ent.Subject{
		ID:   subjectDTO.ID,
		Name: subjectDTO.Name,
	}, nil
}
