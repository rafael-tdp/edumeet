package services

import (
	"edumeet/dtos"
	"edumeet/repositories"
	"errors"
)

type SubjectService struct {
	subjectRepository *repositories.SubjectRepository
}

func NewSubjectService(subjectRepository *repositories.SubjectRepository) *SubjectService {
	return &SubjectService{
		subjectRepository: subjectRepository,
	}
}

func (sr *SubjectService) GetSubject(subjectID string) (*dtos.SubjectDTO, error) {
	subject, err := sr.subjectRepository.GetById(subjectID)
	if err != nil {
		return nil, errors.New("user not found in service")
	}

	subjectDTO, err := dtos.ParseSubjectDTO(subject)

	if err != nil {
		return nil, errors.New("error parsing subject DTO")
	}

	return subjectDTO, nil
}

func (sr *SubjectService) Create(subjectDTO dtos.SubjectDTO) (*dtos.SubjectDTO, error) {

	subjectEnt, err := dtos.ConvertDTOToEnt(&subjectDTO)
	if err != nil {
		return nil, errors.New("error converting DTO to ent")
	}

	subject, err := sr.subjectRepository.Create(subjectEnt)
	if err != nil {
		return nil, errors.New("error creating subject")
	}

	createdSubject, err := dtos.ParseSubjectDTO(subject)

	if err != nil {
		return nil, errors.New("error parsing subject DTO")
	}

	return createdSubject, nil
}

func (sr *SubjectService) Delete(subjectID string) error {
	err := sr.subjectRepository.Delete(subjectID)
	if err != nil {
		return errors.New("error deleting subject")
	}
	return nil
}
