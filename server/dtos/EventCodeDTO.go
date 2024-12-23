package dtos

import (
	"edumeet/ent"
)

type EventCodeDTO struct {
	ID        string  `json:"id"`
	Code      string  `json:"code"`
	CreatedBy *string `json:"createdBy"`
}

func EntToEventCodeDTO(event *ent.Event) *EventCodeDTO {
	return &EventCodeDTO{
		ID:        event.ID,
		Code:      event.Code,
		CreatedBy: event.CreatedBy,
	}
}

func (e *EventCodeDTO) GetCreatedBy() *string {
	return e.CreatedBy
}
