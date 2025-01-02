package services

import (
	"edumeet/dtos"
	"edumeet/repositories"
	"errors"

	"github.com/sirupsen/logrus"
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
		logrus.Error("Error SubjectService.GetSubject: ", err)
		return nil, errors.New("user not found in service")
	}

	subjectDTO := dtos.SubjectEntToDTO(subject)

	logrus.Info("SubjectService.GetSubject: ", subjectDTO)
	return subjectDTO, nil
}

func (sr *SubjectService) Create(subjectDTO dtos.SubjectDTO) (*dtos.SubjectDTO, error) {
	subject, err := sr.subjectRepository.Create(subjectDTO)
	if err != nil {
		logrus.Error("Error SubjectService.Create: ", err)
		return nil, errors.New("error creating subject")
	}

	createdSubject := dtos.SubjectEntToDTO(subject)
	logrus.Info("SubjectService.Create: ", createdSubject)
	return createdSubject, nil
}

func (sr *SubjectService) Delete(subjectID string) error {
	err := sr.subjectRepository.Delete(subjectID)
	if err != nil {
		logrus.Error("Error SubjectService.Delete: ", err)
		return errors.New("error deleting subject")
	}
	return nil
}

func (sr *SubjectService) GetSubjects() ([]*dtos.SubjectDTO, error) {
	subjects, err := sr.subjectRepository.GetSubjects()
	if err != nil {
		logrus.Error("Error SubjectService.GetSubjects: ", err)
		return nil, errors.New("error getting subjects")
	}

	subjectsDTO := make([]*dtos.SubjectDTO, 0)

	for _, subject := range subjects {
		subjectDTO := dtos.SubjectEntToDTO(subject)
		subjectsDTO = append(subjectsDTO, subjectDTO)
	}

	return subjectsDTO, nil
}

func (sr *SubjectService) Update(subjectID string, subjectDTO dtos.SubjectDTO) (*dtos.SubjectDTO, error) {
	subject, err := sr.subjectRepository.Update(subjectID, subjectDTO)
	if err != nil {
		logrus.Error("Error SubjectService.Update: ", err)
		return nil, errors.New("error updating subject")
	}

	updatedSubject := dtos.SubjectEntToDTO(subject)

	if err != nil {
		logrus.Error("Error SubjectService.Update: ", err)
		return nil, errors.New("error parsing subject DTO")
	}

	logrus.Info("SubjectService.Update: ", updatedSubject)
	return updatedSubject, nil
}
