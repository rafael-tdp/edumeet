package validator

import (
	"time"

	"github.com/go-playground/validator/v10"
)

func IsAfterNow(fl validator.FieldLevel) bool {
	startDate := fl.Field().Interface().(time.Time)
	return startDate.After(time.Now())
}
