package controllers

import (
	"edumeet/services"
	"strconv"

	"github.com/gofiber/fiber/v2"
)

type AddressController struct {
	addressService *services.AddressService
}

func NewAddressController(addressService *services.AddressService) *AddressController {
	return &AddressController{
		addressService: addressService,
	}
}

func (ac *AddressController) GetAddress() func(*fiber.Ctx) error {
	return func(c *fiber.Ctx) error {
		queryLat := c.Query("lat")
		queryLng := c.Query("lng")

		if queryLat == "" || queryLng == "" {
			return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Latitude and Longitude are required"})
		}

		lat, err := strconv.ParseFloat(queryLat, 64)
		if err != nil {
			return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid latitude"})
		}
		lng, err := strconv.ParseFloat(queryLng, 64)
		if err != nil {
			return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid longitude"})
		}
		addresses, err := ac.addressService.GetAddress(lat, lng)
		if err != nil {
			return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": err.Error()})
		}
		return c.Status(fiber.StatusOK).JSON(addresses)
	}
}

func (ac *AddressController) GetLatLng() func(*fiber.Ctx) error {
	return func(c *fiber.Ctx) error {
		queryAddress := c.Query("address")

		if queryAddress == "" {
			return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Address is required"})
		}

		latLng, err := ac.addressService.GetLatLng(queryAddress)
		if err != nil {
			return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": err.Error()})
		}
		return c.Status(fiber.StatusOK).JSON(latLng)
	}
}
