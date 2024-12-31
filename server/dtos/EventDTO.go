package dtos

import (
	"edumeet/ent"
	"time"
)

type EventDTO struct {
	ID               string            `json:"id"`
	StartDate        time.Time         `json:"start_date" validate:"required,isAfterNow" error_message:"La date de début doit être dans le futur."`
	EndDate          time.Time         `json:"end_date,omitempty" validate:"required,isBefore" error_message:"La date de fin doit être après la date de début."`
	IsPrivate        bool              `json:"is_private"`
	Title            string            `json:"title" validate:"required,min=3"`
	Description      string            `json:"description,omitempty" validate:"required,min=3"`
	PhysicalEventDTO *PhysicalEventDTO `json:"physical_event,omitempty"`
	RemoteEventDTO   *RemoteEventDTO   `json:"remote_event,omitempty"`
	CreatedBy        *string           `json:"created_by,omitempty"`
	Participants     []ParticipantDTO  `json:"participants,omitempty"`
	Subjects         []string          `json:"subjects,omitempty"`
}

func EntToEventDTO(event *ent.Event) *EventDTO {

	var remoteEventDTO *RemoteEventDTO
	var physicalEventDTO *PhysicalEventDTO

	if event.Edges.RemoteEvent != nil {
		remoteEventDTO = EntToRemoteEventDTO(event.Edges.RemoteEvent)
	}

	if event.Edges.PhysicalEvent != nil {
		physicalEventDTO = EntToPhysicalEventDTO(event.Edges.PhysicalEvent)
	}
	return &EventDTO{
		ID:               event.ID,
		StartDate:        event.StartDate,
		EndDate:          event.EndDate,
		IsPrivate:        event.IsPrivate,
		Title:            event.Title,
		Description:      event.Description,
		RemoteEventDTO:   remoteEventDTO,
		PhysicalEventDTO: physicalEventDTO,
		CreatedBy:        event.CreatedBy,
		Participants:     ConvertParticipants(event.Edges.Participants),
		Subjects:         ConvertSubjects(event.Edges.Subjects),
	}
}

func (e *EventDTO) GetCreatedBy() *string {
	return e.CreatedBy
}

type EventWithTypeDTO struct {
	ID                string            `json:"id"`
	StartDate         time.Time         `json:"start_date"`
	EndDate           time.Time         `json:"end_date,omitempty"`
	IsPrivate         bool              `json:"is_private"`
	Title             string            `json:"title"`
	Description       string            `json:"description,omitempty"`
	Image             string            `json:"image,omitempty"`
	PhysicalEventDTO  *PhysicalEventDTO `json:"physical_event,omitempty"`
	RemoteEventDTO    *RemoteEventDTO   `json:"remote_event,omitempty"`
	ParticipantsCount int               `json:"participants_count"`
	CreatedBy         *string           `json:"created_by,omitempty"`
}

type EventWithDetailsDTO struct {
	ID                string                   `json:"id"`
	StartDate         time.Time                `json:"start_date"`
	EndDate           time.Time                `json:"end_date,omitempty"`
	IsPrivate         bool                     `json:"is_private"`
	Title             string                   `json:"title"`
	Description       string                   `json:"description,omitempty"`
	Image             string                   `json:"image,omitempty"`
	PhysicalEventDTO  *PhysicalEventDTO        `json:"physical_event,omitempty"`
	RemoteEventDTO    *RemoteEventDTO          `json:"remote_event,omitempty"`
	ParticipantsCount int                      `json:"participants_count"`
	Participants      []ParticipantWithUserDTO `json:"participants"`
	EventDocuments    []*EventDocumentDTO      `json:"event_documents"`
	CreatedBy         *string                  `json:"created_by,omitempty"`
	LastMessages      []MessageDTO             `json:"last_messages"`
}
