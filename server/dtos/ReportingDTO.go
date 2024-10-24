package dtos

type ReportingDTO struct {
	ID       string  `json:"id"`
	Reason   string  `json:"reason" validate:"required min=5"`
	Type     string  `json:"type" validate:"required" enum:"USER,MESSAGE,EVENT"`
	EntityID string  `json:"entity_id" validate:"required"`
	User     UserDTO `json:"user,omitempty" validate:"required"`
}
