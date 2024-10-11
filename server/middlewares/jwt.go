package middlewares

import (
	"edumeet/structures"
	"edumeet/utils"
	"fmt"
	"net/http"
	"strings"

	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v5"
)

func JWTAuthMiddleware(c *fiber.Ctx) error {
	jwtKey, err := utils.GetJWTKey()
	if err != nil {
		return c.Status(http.StatusInternalServerError).JSON(fiber.Map{"error": "Could not load JWT key"})
	}

	// Récupérer le token depuis le header Authorization
	authHeader := c.Get("Authorization")
	if authHeader == "" {
		return c.Status(http.StatusUnauthorized).JSON(fiber.Map{"error": "Missing Authorization Header"})
	}

	tokenString := strings.TrimPrefix(authHeader, "Bearer ")
	if tokenString == authHeader {
		return c.Status(http.StatusUnauthorized).JSON(fiber.Map{"error": "Invalid Authorization header format"})
	}

	// Utilisez la struct Claims sans pointeur pour RegisteredClaims
	claims := &structures.Claims{}

	// Parse et valider le token
	token, err := jwt.ParseWithClaims(tokenString, claims, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, utils.ErrInvalidSigningMethod
		}
		return jwtKey, nil
	})

	if err != nil {
		fmt.Println("JWT Parse Error: ", err)
		return c.Status(http.StatusUnauthorized).JSON(fiber.Map{"error": "Token parsing error", "details": err.Error()})
	}

	if !token.Valid {
		return c.Status(http.StatusUnauthorized).JSON(fiber.Map{"error": "Invalid token", "details": "Token is not valid"})
	}

	c.Locals("user_id", claims.UserID)
	c.Locals("email", claims.Email)

	return c.Next()
}
