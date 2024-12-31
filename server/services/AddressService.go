package services

import (
	"edumeet/utils"
)

type AddressService struct{}

func NewAddressService() *AddressService {
	return &AddressService{}
}

func (r *AddressService) GetAddress(lat float64, lng float64) (interface{}, error) {
	address, err := utils.GetAddress(lat, lng)
	if err != nil {
		return nil, err
	}

	return map[string]interface{}{
		"address": address,
	}, nil
}

func (r *AddressService) GetLatLng(address string) (interface{}, error) {
	lat, lng, err := utils.GetLatLng(address)
	if err != nil {
		return nil, err
	}

	return map[string]interface{}{
		"lat": lat,
		"lng": lng,
	}, nil
}
