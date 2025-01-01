package validator

import (
	"github.com/go-playground/validator/v10"
	"regexp"
)

func IsUsernameValid(fl validator.FieldLevel) bool {
	username := fl.Field().String()
	usernameRegex := `^[a-zA-Z][a-zA-Z0-9_-]{2,29}$`
	matched, err := regexp.MatchString(usernameRegex, username)
	if err != nil {
		return false
	}
	return matched
}

func IsPasswordValid(fl validator.FieldLevel) bool {
	password := fl.Field().String()
	if len(password) < 8 {
		return false
	}

	hasUppercase := `[A-Z]`
	if matched, _ := regexp.MatchString(hasUppercase, password); !matched {
		return false
	}

	hasDigit := `\d`
	if matched, _ := regexp.MatchString(hasDigit, password); !matched {
		return false
	}

	hasSpecialChar := `[!@#$%^&*(),.?":{}|<>]`
	if matched, _ := regexp.MatchString(hasSpecialChar, password); !matched {
		return false
	}

	return true
}
