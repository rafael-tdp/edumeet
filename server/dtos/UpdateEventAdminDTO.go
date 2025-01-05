package dtos

type UpdateEventAdminDTO struct {
	Title     string `json:"title" validate:"required"`
	IsPrivate bool   `json:"isPrivate"`
}
