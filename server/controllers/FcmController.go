package controllers

import (
	"edumeet/ent"
	"edumeet/utils"

	"github.com/gofiber/fiber/v2"
)

type FcmController struct {
}

func NewFcmController() *FcmController {
	return &FcmController{}
}

func (fcm *FcmController) StoreFcmToken(c *fiber.Ctx) error {

	currentUser := c.Locals("user").(*ent.User)
	fcm_token := c.Params("token")

	// Store the FCM token in the database
	utils.StoreTokenInRedis(currentUser.ID+"_FCM", fcm_token)

	return c.Status(fiber.StatusOK).JSON(fiber.Map{"message": "FCM token stored successfully"})
}
