package services

import (
	"edumeet/utils"

	"github.com/sirupsen/logrus"
)

type AddressService struct{}

func NewAddressService() *AddressService {
	return &AddressService{}
}

func (r *AddressService) GetAddress(lat float64, lng float64) (interface{}, error) {
	address, err := utils.GetAddress(lat, lng)
	if err != nil {
		logrus.Error("Error AddressService function GetAddress: ", err)
		return nil, err
	}

	logrus.Info("AddressService function GetAddress: ", address)
	return map[string]interface{}{
		"address": address,
	}, nil
}

func (r *AddressService) GetLatLng(address string) (interface{}, error) {
	lat, lng, err := utils.GetLatLng(address)
	if err != nil {
		logrus.Error("Error AddressService function GetLatLng: ", err)
		return nil, err
	}

	logrus.Info("AddressService function GetLatLng: ", lat, lng)
	return map[string]interface{}{
		"lat": lat,
		"lng": lng,
	}, nil
}
