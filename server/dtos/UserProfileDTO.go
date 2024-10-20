package dtos

type UserProfileDTO struct {
	Username string   `json:"username"`
	Bio      *string  `json:"bio,omitempty"`
	Picture  *string  `json:"picture,omitempty"`
	Lng      *float64 `json:"lng,omitempty"`
	Lat      *float64 `json:"lat,omitempty"`
}
