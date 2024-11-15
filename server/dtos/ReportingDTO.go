package dtos

import "edumeet/ent"

type ReportingDTO struct {
	ID       string      `json:"id,omitempty"`
	Reason   string      `json:"reason" validate:"required,min=5"`
	Type     string      `json:"type" validate:"required,oneof=USER MESSAGE EVENT"`
	EntityID string      `json:"entity_id" validate:"required"`
	UserID   string      `json:"user_id,omitempty"`
	Entity   interface{} `json:"entity,omitempty"`
	User     interface{} `json:"user,omitempty"`
}

func ReportingEntToDTO(reporting *ent.Reporting, entity interface{}) ReportingDTO {
	return ReportingDTO{
		ID:     reporting.ID,
		Reason: reporting.Reason,
		Type:   reporting.Type,
		Entity: entity,
		User:   reporting.Edges.User,
	}
}
