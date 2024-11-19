package dtos

import (
	"edumeet/ent"
	"mime/multipart"
)

type DocumentDTO struct {
	ID        string                `json:"id,omitempty"`
	Path      string                `json:"path,omitempty"`
	Type      string                `json:"type,omitempty"`
	EventID   string                `json:"event_id,omitempty" validate:"checkEventMessageEmpty" error_message:"Cannot have both event_id and message_id empty"`
	MessageID string                `json:"message_id,omitempty" validate:"checkEventMessageFilled" error_message:"Cannot have both event_id and message_id filled"`
	File      *multipart.FileHeader `json:"file" validate:"maxFileSizeInMB" error_message:"File size must be less than 25MB"`
}

func DocumentEntToDTO(document *ent.Document) DocumentDTO {
	return DocumentDTO{
		ID:      document.ID,
		Path:    document.Path,
		Type:    document.Edges.EventDocuments[0].Type,
		EventID: document.Edges.EventDocuments[0].ID,
		//MessageID: document.Edges.Message.ID,
	}
}
