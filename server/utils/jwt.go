package utils

import (
	"edumeet/ent/user"
	"edumeet/structures"
	"log"
	"os"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/joho/godotenv"
)

func GenerateJWT(email string, id string, role user.Role) (string, error) {
	jwtKey, err := GetJWTKey()
	if err != nil {
		return "", err
	}

	expirationTime := time.Now().Add(time.Hour * 1)

	claims := &structures.Claims{
		Email:  email,
		UserID: id,
		Role:   role,
		RegisteredClaims: jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(expirationTime),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	tokenString, err := token.SignedString(jwtKey)
	if err != nil {
		return "", err
	}

	return tokenString, nil
}

func GetJWTKey() ([]byte, error) {
	err := godotenv.Load()
	if err != nil {
		log.Fatalf("Error loading .env file: %v", err)
	}
	jwtKey := []byte(os.Getenv("JWT_SECRET"))

	return jwtKey, nil
}
