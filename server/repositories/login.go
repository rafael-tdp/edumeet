package repositories

import (
	"edumeet/db"
	"edumeet/ent/user"
	"edumeet/structures"
	"edumeet/utils"

	"github.com/gofiber/fiber/v2"
)

func LoginHandler(c *fiber.Ctx) error {

	var requestBody structures.Login

	if err := c.BodyParser(&requestBody); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	}

	client, err := db.OpenDBConnection()

	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "Could not connect to database"})
	}

	user, err := client.User.Query().Where(user.Email(requestBody.Username)).Only(c.Context())
	if err != nil {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "Invalid username or password"})
	}

	bcryptUtil := &utils.Bcrypt{}
	if !bcryptUtil.CheckPasswordHash(requestBody.Password, user.Password) {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "Invalid username or password"})
	}

	if !user.Activated {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "Account not activated"})
	}

	var jwtToken, jwtErr = utils.GenerateJWT(user.Username)

	if jwtErr != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "Could not generate token"})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{"token": jwtToken})
}
