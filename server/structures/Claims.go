package structures

import (
	"edumeet/ent/user"

	"github.com/golang-jwt/jwt/v5"
)

type Claims struct {
	Email  string    `json:"email"`
	UserID string    `json:"user_id"`
	Role   user.Role `json:"role"`
	jwt.RegisteredClaims
}
