package routes

import (
	"edumeet/controllers"
	"edumeet/ent"
	"edumeet/services"

	"github.com/gofiber/fiber/v2"
)

func setupRoutesAddress(app *fiber.App, addressController *controllers.AddressController) {

	app.Get("/address", addressController.GetAddress())
	app.Get("/address/reverse", addressController.GetLatLng())
}

func initAddressController(client *ent.Client) *controllers.AddressController {

	addressService := services.NewAddressService()
	return controllers.NewAddressController(addressService)
}
