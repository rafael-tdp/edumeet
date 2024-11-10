package dtos

import (
	"edumeet/ent"
	"errors"
)

type RemoteEventDTO struct {
	EventDTO
	URL string `json:"url"`
}

func (dto *RemoteEventDTO) ToEntEvent() (*ent.Event, error) {
	if dto == nil {
		return nil, errors.New("remoteEventDTO is nil")
	}

	event := &ent.Event{
		Title:       dto.Title,
		Description: dto.Description,
		StartDate:   dto.StartDate,
		EndDate:     dto.EndDate,
		IsPrivate:   dto.IsPrivate,
		NbMaxUser:   dto.NbMaxUser,
	}

	return event, nil
}

func (dto *RemoteEventDTO) ToEntRemoteEvent() (*ent.RemoteEvent, error) {
	if dto == nil {
		return nil, errors.New("remoteEventDTO is nil")
	}

	remoteEvent := &ent.RemoteEvent{
		URL: dto.URL,
	}

	return remoteEvent, nil
}

func EntToRemoteEventDTO(remoteEvent *ent.RemoteEvent, event *ent.Event) *RemoteEventDTO {

	return &RemoteEventDTO{
		URL: remoteEvent.URL,
		EventDTO: EventDTO{
			ID:          event.ID,
			Title:       event.Title,
			Description: event.Description,
			StartDate:   event.StartDate,
			EndDate:     event.EndDate,
			IsPrivate:   event.IsPrivate,
			NbMaxUser:   event.NbMaxUser,
		},
	}
}
