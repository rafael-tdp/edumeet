package validator

import (
	"time"

	"github.com/go-playground/validator/v10"
)

func IsBefore(fl validator.FieldLevel) bool {

	endDate := fl.Field().Interface().(time.Time)

	startDateField := fl.Parent().FieldByName("StartDate")
	if !startDateField.IsValid() {
		return false
	}

	startDate := startDateField.Interface().(time.Time)

	return endDate.After(startDate)
}
