package dtos

import "mime/multipart"

type DocumentDTO struct {
	ID        string                `json:"id,omitempty"`
	Path      string                `json:"path,omitempty"`
	Type      string                `json:"type,omitempty"`
	EventID   string                `json:"event_id,omitempty"`
	MessageID string                `json:"message_id,omitempty"`
	File      *multipart.FileHeader `json:"file"`
}
