package utils

import "errors"

var (
	ErrInvalidCredentials   = errors.New("invalid credentials")
	ErrAccountNotActivated  = errors.New("account not activated")
	ErrInvalidSigningMethod = errors.New("invalid signing method")
	ErrAccountNotRegistered = errors.New("account not registered")
)
