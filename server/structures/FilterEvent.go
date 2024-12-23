package structures

type EventFilters struct {
	Type      string // "remote", "physical", "all"
	Subjects  string `json:"subjects"` // IDs séparés par des virgules
	Distance  string // Distance en km
	Longitude string // Longitude (float sous forme de chaîne)
	Latitude  string // Latitude (float sous forme de chaîne)
}
