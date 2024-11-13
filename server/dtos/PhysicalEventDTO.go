package dtos

import (
	"edumeet/ent"
	"errors"
)

type PhysicalEventDTO struct {
	EventDTO
	Location string  `json:"location"`
	Lng      float64 `json:"lng"`
	Lat      float64 `json:"lat"`
}

func (dto *PhysicalEventDTO) ToEntEvent() (*ent.Event, error) {
	if dto == nil {
		return nil, errors.New("physicalEventDTO is nil")
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

func (dto *PhysicalEventDTO) ToEntPhysicalEvent() (*ent.PhysicalEvent, error) {
	if dto == nil {
		return nil, errors.New("physicalEventDTO is nil")
	}

	physicalEvent := &ent.PhysicalEvent{
		Location: dto.Location,
		Lng:      dto.Lng,
		Lat:      dto.Lat,
	}

	return physicalEvent, nil
}

func EntToPhysicalEventDTO(physicalEvent *ent.PhysicalEvent, event *ent.Event) *PhysicalEventDTO {

	return &PhysicalEventDTO{
		Location: physicalEvent.Location,
		Lng:      physicalEvent.Lng,
		Lat:      physicalEvent.Lat,
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
