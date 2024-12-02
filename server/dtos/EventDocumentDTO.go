package dtos

import (
	"edumeet/ent"
	"time"
)

type EventDocumentDTO struct {
	DocumentID string    `json:"document_id"`
	Type       string    `json:"type"`
	Path       string    `json:"path"`
	CreatedAt  time.Time `json:"created_at"`
	Name       string    `json:"name"`
}

func EntToEventDocumentDTO(eventDocument []*ent.EventDocument) []*EventDocumentDTO {
	var eventDocumentDTO []*EventDocumentDTO
	for _, ed := range eventDocument {
		eventDocumentDTO = append(eventDocumentDTO, &EventDocumentDTO{
			DocumentID: ed.Edges.Document.ID,
			Type:       ed.Type,
			Name:       ed.Edges.Document.Name,
			Path:       ed.Edges.Document.Path,
			CreatedAt:  ed.Edges.Document.CreatedAt,
		})
	}

	return eventDocumentDTO
}
