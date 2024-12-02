package services

import (
	"context"
	"edumeet/dtos"
	"edumeet/repositories"
	"edumeet/utils"
	"path"

	"github.com/gomutex/godocx"
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
		return "", err
	}

	return exo, nil
}

func (ai *AIService) GenerateCorrection(exercice string) (string, error) {
	exo, err := utils.GenerateCorrectionPrompt(exercice)
	if err != nil {
		return "", err
	}

	return exo, nil
}

func (ai *AIService) SaveGenerateDocument(ctx context.Context, aiDocumentDTO dtos.AIDocumentSaveDTO) error {
	doc, err := godocx.NewDocument()
	if err != nil {
		return err
	}

	doc.AddParagraph(aiDocumentDTO.Content)
	ulid := utils.ULID{}
	filename := ulid.GenerateUlid()() + "-" + aiDocumentDTO.DocType + ".docx"
	path := path.Join("documentUpload", filename)
	err = doc.SaveTo(path)
	if err != nil {
		return err
	}

	_, err = ai.eventRepo.GetEvent(aiDocumentDTO.EventID)
	if err != nil {
		return err
	}

	documentDTO := dtos.DocumentDTO{
		Name:    filename,
		Type:    aiDocumentDTO.DocType,
		Path:    path,
		EventID: aiDocumentDTO.EventID,
	}

	_, err = ai.documentRepo.CreateDocument(ctx, documentDTO)
	if err != nil {
		return err
	}

	return nil
}
