package validator

import (
	"mime/multipart"

	"github.com/go-playground/validator/v10"
)

func MaxFileSizeInMB(file *multipart.FileHeader) func(fl validator.FieldLevel) bool {
	return func(fl validator.FieldLevel) bool {
		return file.Size < 25*1024*1024
	}
}
