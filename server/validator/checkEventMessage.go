package validator

import (
	"github.com/go-playground/validator/v10"
)

func CheckEventMessageEmpty(fl validator.FieldLevel) bool {
	eventID := fl.Field().String()
	messageID := fl.Parent().FieldByName("MessageID").String()

	return eventID != "" || messageID != ""
}

func CheckEventMessageFilled(fl validator.FieldLevel) bool {
	messageID := fl.Field().String()
	eventID := fl.Parent().FieldByName("EventID").String()

	return !(eventID != "" && messageID != "")
}
