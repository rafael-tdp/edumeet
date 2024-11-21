package dtos

type ResetPasswordDTO struct {
	Email    string `json:"email"`
	Code     string `json:"code"`
	Password string `json:"password"`
}
