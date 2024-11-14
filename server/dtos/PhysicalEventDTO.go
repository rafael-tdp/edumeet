package dtos

import "edumeet/ent"

type PhysicalEventDTO struct {
	Location string  `json:"location"`
	Lng      float64 `json:"lng"`
	Lat      float64 `json:"lat"`
}

func EntToPhysicalEventDTO(physicalEvent *ent.PhysicalEvent) *PhysicalEventDTO {
	return &PhysicalEventDTO{
		Location: physicalEvent.Location,
		Lng:      physicalEvent.Lng,
		Lat:      physicalEvent.Lat,
	}
}
