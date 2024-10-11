package structures

import "github.com/golang-jwt/jwt/v5"

type Claims struct {
	Email  string `json:"email"`
	UserID string `json:"user_id"`
	jwt.RegisteredClaims
}
