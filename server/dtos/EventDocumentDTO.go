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
	IsLiked    bool      `json:"is_liked"`
}

func EntToEventDocumentDTO(eventDocument []*ent.EventDocument, userId string) []*EventDocumentDTO {
	var eventDocumentDTO []*EventDocumentDTO
	for _, ed := range eventDocument {

		isLiked := false

		for _, user := range ed.Edges.Document.Edges.Users {
			if user.ID == userId {
				isLiked = true
				break
			}
		}

		eventDocumentDTO = append(eventDocumentDTO, &EventDocumentDTO{
			DocumentID: ed.Edges.Document.ID,
			Type:       ed.Type,
			Name:       ed.Edges.Document.Name,
			Path:       ed.Edges.Document.Path,
			CreatedAt:  ed.Edges.Document.CreatedAt,
			IsLiked:    isLiked,
		})
	}

	return eventDocumentDTO
}
