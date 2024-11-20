package dtos

type ValidateUserDTO struct {
	Code  string `json:"code" validate:"required"`
	Email string `json:"email" validate:"required"`
}
