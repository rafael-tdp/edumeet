package services

import (
	"context"
	"edumeet/dtos"
	"edumeet/ent"
	"edumeet/repositories"
	"edumeet/utils"
	"fmt"
	"io"
	"os"
)

type DocumentService struct {
	documentRepo *repositories.DocumentRepository
	eventRepo    *repositories.EventRepository
}

func NewDocumentService(documentRepo *repositories.DocumentRepository, eventRepo *repositories.EventRepository) *DocumentService {
	return &DocumentService{
		documentRepo: documentRepo,
		eventRepo:    eventRepo,
	}
}

func (r *DocumentService) GetDocumentById(documentID string) (dtos.DocumentResponseDTO, error) {
	document, err := r.documentRepo.GetDocumentById(documentID)
	if err != nil {
		return dtos.DocumentResponseDTO{}, err
	}

	documentDTO := dtos.DocumentResponseDTO{
		ID:   document.ID,
		Path: document.Path,
		Name: document.Name,
	}

	return documentDTO, nil
}

func (r *DocumentService) DeleteDocument(documentID string) error {
	document, err := r.documentRepo.GetDocumentById(documentID)
	if err != nil {
		return err
	}
	err = os.Remove(document.Path)
	if err != nil {
		return err
	}
	err = r.documentRepo.DeleteDocument(document.ID)
	if err != nil {
		return err
	}

	return nil
}

func (r *DocumentService) CreateDocument(ctx context.Context, documentDTO dtos.DocumentDTO) (dtos.DocumentDTO, error) {
	if documentDTO.EventID != "" {
		_, err := r.eventRepo.GetEvent(documentDTO.EventID)
		if err != nil {
			return dtos.DocumentDTO{}, err
		}
	} //else if documentDTO.MessageID != "" {
	// 	_, err = r.messageRepo.GetMessageById(documentDTO.MessageID)
	// 	if err != nil {
	// 		return dtos.DocumentDTO{}, err
	// 	}
	// }
	uploadDir := "documentUpload/"
	fileName := documentDTO.File.Filename
	ulid := utils.ULID{}
	filePath := fmt.Sprintf("%s%s-%s", uploadDir, ulid.GenerateUlid()(), fileName)
	dstFile, err := os.Create(filePath)
	if err != nil {
		return dtos.DocumentDTO{}, err
	}

	defer dstFile.Close()

	file, err := documentDTO.File.Open()
	if err != nil {
		return dtos.DocumentDTO{}, err
	}

	defer file.Close()

	_, err = io.Copy(dstFile, file)
	if err != nil {
		return dtos.DocumentDTO{}, err
	}

	documentDTO.Path = filePath

	documentCreated, err := r.documentRepo.CreateDocument(ctx, documentDTO)

	if err != nil {
		return dtos.DocumentDTO{}, err
	}

	documentDTO = dtos.DocumentEntToDTO(documentCreated)

	return documentDTO, nil
}

func (ds *DocumentService) GetEventDocuments(eventID string) ([]dtos.EventDocumentDTO, error) {
	eventDocuments, err := ds.documentRepo.GetEventDocuments(eventID)
	if err != nil {
		return []dtos.EventDocumentDTO{}, err
	}

	eventDocumentDTOs := make([]dtos.EventDocumentDTO, 0, len(eventDocuments))

	for _, eventDocument := range eventDocuments {
		dto := dtos.EntToEventDocumentDTO([]*ent.EventDocument{eventDocument})
		for _, d := range dto {
			eventDocumentDTOs = append(eventDocumentDTOs, *d)
		}
	}

	return eventDocumentDTOs, nil
}
