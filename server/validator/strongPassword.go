package validator

import (
	"regexp"

	"github.com/go-playground/validator/v10"
)

func StrongPassword(fl validator.FieldLevel) bool {
	password := fl.Field().String()
	hasNumber := regexp.MustCompile(`[0-9]`).MatchString(password)
	hasLower := regexp.MustCompile(`[a-z]`).MatchString(password)
	hasUpper := regexp.MustCompile(`[A-Z]`).MatchString(password)
	hasSpecial := regexp.MustCompile(`[@#$%^&+=!?.%]`).MatchString(password)

	return hasNumber && hasLower && hasUpper && hasSpecial
}
