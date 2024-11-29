package dtos

import (
	"edumeet/ent"
	"mime/multipart"
)

type DocumentDTO struct {
	ID        string                `json:"id,omitempty"`
	Name      string                `json:"name,omitempty"`
	Path      string                `json:"path,omitempty"`
	Type      string                `json:"type,omitempty"`
	EventID   string                `json:"event_id,omitempty" validate:"checkEventMessageEmpty" error_message:"Cannot have both event_id and message_id empty"`
	MessageID string                `json:"message_id,omitempty" validate:"checkEventMessageFilled" error_message:"Cannot have both event_id and message_id filled"`
	File      *multipart.FileHeader `json:"file" validate:"maxFileSizeInMB" error_message:"File size must be less than 25MB"`
}

type DocumentResponseDTO struct {
	ID   string `json:"id,omitempty"`
	Path string `json:"path,omitempty"`
	Name string `json:"name,omitempty"`
}

// type EventDocumentDTO struct {
// 	ID       string              `json:"id,omitempty"`
// 	Type     string              `json:"type,omitempty"`
// 	Document DocumentResponseDTO `json:"document,omitempty"`
// }

func DocumentEntToDTO(document *ent.Document) DocumentDTO {
	return DocumentDTO{
		ID:   document.ID,
		Path: document.Path,
		Name: document.Name,
		// Type:    document.Edges.EventDocuments[0].Type,
		// EventID: document.Edges.EventDocuments[0].ID,
		//MessageID: document.Edges.Message.ID,
	}
}

// func EventDocumentEntToDTO(eventDocument *ent.EventDocument) EventDocumentDTO {
// 	return EventDocumentDTO{
// 		ID:   eventDocument.ID,
// 		Type: eventDocument.Type,
// 		Document: DocumentResponseDTO{
// 			ID:   eventDocument.Edges.Document.ID,
// 			Path: eventDocument.Edges.Document.Path,
// 			Name: eventDocument.Edges.Document.Name,
// 		},
// 	}
// }

// func ConvertEventDocuments(eventDocuments []*ent.EventDocument) []EventDocumentDTO {
// 	var eventDocumentDTOs []EventDocumentDTO
// 	for _, eventDocument := range eventDocuments {
// 		eventDocumentDTOs = append(eventDocumentDTOs, EventDocumentEntToDTO(eventDocument))
// 	}
// 	return eventDocumentDTOs
// }
