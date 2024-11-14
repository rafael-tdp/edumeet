package dtos

import (
	"edumeet/ent"
	"time"
)

type EventDTO struct {
	ID               string            `json:"id"`
	NbMaxUser        int               `json:"nb_max_user"`
	StartDate        time.Time         `json:"start_date"`
	EndDate          time.Time         `json:"end_date,omitempty"`
	IsPrivate        bool              `json:"is_private"`
	Title            string            `json:"title"`
	Description      string            `json:"description,omitempty"`
	InvitationLink   string            `json:"invitation_link,omitempty"`
	PhysicalEventDTO *PhysicalEventDTO `json:"physical_event,omitempty"`
	RemoteEventDTO   *RemoteEventDTO   `json:"remote_event,omitempty"`
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
		NbMaxUser:        event.NbMaxUser,
		StartDate:        event.StartDate,
		EndDate:          event.EndDate,
		IsPrivate:        event.IsPrivate,
		Title:            event.Title,
		Description:      event.Description,
		InvitationLink:   event.InvitationLink,
		RemoteEventDTO:   remoteEventDTO,
		PhysicalEventDTO: physicalEventDTO,
	}
}
