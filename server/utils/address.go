package utils

import (
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"net/url"
	"strconv"
	"strings"
)

func GetAddress(lat float64, lng float64) (string, error) {
	response, err := http.Get(fmt.Sprintf("https://nominatim.openstreetmap.org/reverse?lat=%g&lon=%g&format=json", lat, lng))
	if err != nil {
		return "", err
	}

	defer response.Body.Close()

	if response.StatusCode != http.StatusOK {
		return "", errors.New("error nomatim response")
	}

	var addressObject struct {
		Address struct {
			HouseNumber string `json:"house_number"`
			Road        string `json:"road"`
			City        string `json:"city"`
			Postcode    string `json:"postcode"`
			Country     string `json:"country"`
		} `json:"address"`
	}

	err = json.NewDecoder(response.Body).Decode(&addressObject)
	if err != nil {
		return "", err
	}

	fullAddress := fmt.Sprintf("%s %s, %s %s, %s", strings.Split(addressObject.Address.HouseNumber, ";")[0], addressObject.Address.Road, addressObject.Address.City, addressObject.Address.Postcode, addressObject.Address.Country)

	return fullAddress, nil
}

func GetLatLng(address string) (float64, float64, error) {
	response, err := http.Get(fmt.Sprintf("https://nominatim.openstreetmap.org/search?q=%s&format=json", url.QueryEscape(address)))
	if err != nil {
		return 0, 0, err
	}

	defer response.Body.Close()

	if response.StatusCode != http.StatusOK {
		return 0, 0, errors.New("error nomatim response")
	}

	var latAndLngObject []struct {
		Lat string `json:"lat"`
		Lon string `json:"lon"`
	}

	err = json.NewDecoder(response.Body).Decode(&latAndLngObject)
	if err != nil {
		return 0, 0, err
	}

	lat, err := strconv.ParseFloat(latAndLngObject[0].Lat, 64)
	if err != nil {
		return 0, 0, err
	}

	lng, err := strconv.ParseFloat(latAndLngObject[0].Lon, 64)
	if err != nil {
		return 0, 0, err
	}

	return lat, lng, nil
}
