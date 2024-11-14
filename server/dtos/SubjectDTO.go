package dtos

import (
	"edumeet/ent"
)

type SubjectDTO struct {
	ID   string `json:"id"`
	Name string `json:"name"`
}

func SubjectEntToDTO(subject *ent.Subject) *SubjectDTO {
	return &SubjectDTO{
		ID:   subject.ID,
		Name: subject.Name,
	}
}
