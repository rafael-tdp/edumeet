package services

import (
	"edumeet/dtos"
	"edumeet/repositories"
	"edumeet/utils"
	"fmt"
	"io"
	"os"
)

type DocumentService struct {
	documentRepo *repositories.DocumentRepository
}

func NewDocumentService(documentRepo *repositories.DocumentRepository) *DocumentService {
	return &DocumentService{
		documentRepo: documentRepo,
	}
}

func (r *DocumentService) GetDocumentById(documentID string) (dtos.DocumentDTO, error) {
	document, err := r.documentRepo.GetDocumentById(documentID)
	if err != nil {
		return dtos.DocumentDTO{}, err
	}

	if err != nil {
		return dtos.DocumentDTO{}, err
	}

	documentDTO := dtos.DocumentDTO{
		ID:   document.ID,
		Path: document.Path,
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

func (r *DocumentService) CreateDocument(documentDTO dtos.DocumentDTO) (dtos.DocumentDTO, error) {
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

	err = r.documentRepo.CreateDocument(documentDTO)

	return documentDTO, nil
}
