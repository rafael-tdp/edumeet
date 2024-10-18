package dtos

type ResetPasswordDTO struct {
	PlainPassword   string `json:"plainPassword" validate:"required,min=8,max=30,strongPassword"`
	ConfirmPassword string `json:"confirmPassword" validate:"required,eqfield=PlainPassword"`
}
