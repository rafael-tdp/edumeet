package dtos

type ReportingDTO struct {
	ID       string `json:"id,omitempty"`
	Reason   string `json:"reason" validate:"required,min=5"`
	Type     string `json:"type" validate:"required,oneof=USER MESSAGE EVENT"`
	EntityID string `json:"entity_id" validate:"required"`
	UserID   string `json:"user_id,omitempty"`
}
