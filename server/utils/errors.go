package utils

import "errors"

var (
	ErrInvalidCredentials  = errors.New("invalid credentials")
	ErrAccountNotActivated = errors.New("account not activated")
)
