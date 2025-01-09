package services

import (
	"context"
	"edumeet/dtos"
	"edumeet/repositories"
	"edumeet/utils"
	"os"
	"path"

	"github.com/sirupsen/logrus"
)

type AIService struct {
	documentRepo *repositories.DocumentRepository
	eventRepo    *repositories.EventRepository
}

func NewAIService(documentRepo *repositories.DocumentRepository, eventRepo *repositories.EventRepository) *AIService {
	return &AIService{
		documentRepo: documentRepo,
		eventRepo:    eventRepo,
	}
}

func (ai *AIService) GenerateExo(statement string) (string, error) {
	exo, err := utils.GenerateExercisePrompt(statement)
	if err != nil {
		logrus.Error("Error AIService function GenerateExo: ", err)
		return "", err
	}

	logrus.Info("AIService function GenerateExo: ", exo)
	return exo, nil
}

func (ai *AIService) GenerateCorrection(exercice string) (string, error) {
	exo, err := utils.GenerateCorrectionPrompt(exercice)
	if err != nil {
		logrus.Error("Error AIService function GenerateCorrection: ", err)
		return "", err
	}

	logrus.Info("AIService function GenerateCorrection: ", exo)
	return exo, nil
}

func (ai *AIService) SaveGenerateDocument(ctx context.Context, aiDocumentDTO dtos.AIDocumentSaveDTO) error {
	ulid := utils.ULID{}
	filename := ulid.GenerateUlid()() + "-" + aiDocumentDTO.DocType + ".txt"
	path := path.Join("documentUpload", filename)
	file, err := os.Create(path)
	if err != nil {
		logrus.Error("Error AIService function SaveGenerateDocument: ", err)
		return err
	}
	defer file.Close()

	_, err = file.WriteString(aiDocumentDTO.Content)
	if err != nil {
		logrus.Error("Error AIService function SaveGenerateDocument: ", err)
		return err
	}

	event, err := ai.eventRepo.GetEvent(aiDocumentDTO.EventID)
	if err != nil {
		logrus.Error("Error AIService function SaveGenerateDocument: ", err)
		return err
	}

	documentDTO := dtos.DocumentDTO{
		Name:    filename,
		Type:    aiDocumentDTO.DocType,
		Path:    path,
		EventID: aiDocumentDTO.EventID,
	}

	_, err = ai.documentRepo.CreateDocument(ctx, documentDTO, event.Title)
	if err != nil {
		logrus.Error("Error AIService function SaveGenerateDocument: ", err)
		return err
	}

	return nil
}
