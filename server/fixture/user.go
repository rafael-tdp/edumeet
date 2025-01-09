package fixture

import (
	"context"
	"edumeet/ent"
	"edumeet/utils"
	"encoding/json"
	"net/http"
	"net/url"
	"strconv"
	"strings"
	"time"

	"math/rand"

	"github.com/brianvoe/gofakeit/v7"
)

type User struct{}

func (u *User) GenerateUser(ctx context.Context, client *ent.Client) {
	physicalUser := []string{"Zaid", "Jugurtha", "Rafael", "Makan"}
	pictures := []string{
		"adventurer",
		"avaraaars",
		"bigSmile",
		"bottts",
		"bigEars",
		"identicon",
		"initials",
	}
	dateUtils := utils.Date{}
	bcryptUtils := utils.Bcrypt{}
	ulid := utils.ULID{}
	for i := 0; i < len(physicalUser); i++ {
		var address string
		for {
			address = GetRandomAddress()
			if address != "" {
				break
			}
		}
		lat, lng, err := utils.GetLatLng(address)
		if err != nil {
			panic(err)
		}
		id := ulid.GenerateUlid()()
		password, err := bcryptUtils.HashPassword("Password1234!!")
		if err != nil {
			panic(err)
		}

		client.User.Create().
			SetID(id).
			SetEmail(strings.ToLower(physicalUser[i]) + "@user.com").
			SetUsername(strings.ToLower(physicalUser[i])).
			SetLastname(strings.ToLower(gofakeit.LastName())).
			SetFirstname(strings.ToLower(physicalUser[i])).
			SetPassword(password).
			SetBirthDate(dateUtils.GenerateBirthDate()).
			SetBio(gofakeit.Sentence(10)).
			SetActivated(true).
			SetAddress(address).
			SetLng(lng).
			SetLat(lat).
			SetCreatedBy(id).
			SetUpdatedBy(id).
			SetPicture(pictures[gofakeit.Number(0, len(pictures)-1)]).
			SetRole("ADMIN").
			SaveX(ctx)
	}

	for i := 0; i < 20; i++ {
		var address string
		for {
			address = GetRandomAddress()
			if address != "" {
				break
			}
		}
		lat, lng, err := utils.GetLatLng(address)
		if err != nil {
			panic(err)
		}
		id := ulid.GenerateUlid()()
		password, err := bcryptUtils.HashPassword("Password1234!!")
		if err != nil {
			panic(err)
		}

		client.User.Create().
			SetID(id).
			SetEmail(strings.ToLower(gofakeit.FirstName()) + "@user.com").
			SetUsername(strings.ToLower(gofakeit.FirstName())).
			SetLastname(strings.ToLower(gofakeit.LastName())).
			SetFirstname(strings.ToLower(gofakeit.FirstName())).
			SetPassword(password).
			SetBirthDate(dateUtils.GenerateBirthDate()).
			SetBio(gofakeit.Sentence(10)).
			SetActivated(true).
			SetAddress(address).
			SetLng(lng).
			SetLat(lat).
			SetCreatedBy(id).
			SetUpdatedBy(id).
			SetPicture(pictures[gofakeit.Number(0, len(pictures)-1)]).
			SetRole("USER").
			SaveX(ctx)
	}
}

func (u *User) AddSubject(ctx context.Context, client *ent.Client) {
	subjects := client.Subject.Query().AllX(ctx)

	users := client.User.Query().AllX(ctx)

	for _, user := range users {
		for i := 0; i < gofakeit.Number(1, 5); i++ {
			_, err := user.Update().AddSubjects(subjects[gofakeit.Number(0, len(subjects)-1)]).Save(ctx)
			if err != nil {
			}
		}
	}

}

func (u *User) AddBadge(ctx context.Context, client *ent.Client) {
	badges := client.Badge.Query().AllX(ctx)

	users := client.User.Query().AllX(ctx)

	for _, user := range users {
		for i := 0; i < gofakeit.Number(1, 6); i++ {
			_, err := user.Update().AddBadges(badges[gofakeit.Number(0, len(badges)-1)]).Save(ctx)
			if err != nil {
			}
		}
	}
}

func GetRandomAddress() string {
	rand.Seed(time.Now().UnixNano())
	streetType := []string{"Rue", "Avenue", "Boulevard", "Chemin"}

	var address string
	for {
		streetNumber := strconv.Itoa(rand.Intn(50) + 1)
		randomStreetType := streetType[rand.Intn(len(streetType))]
		randomString := url.QueryEscape(streetNumber + " " + randomStreetType)

		fetchAddress, err := http.Get("https://api-adresse.data.gouv.fr/search/?q=" + randomString + "&type=housenumber&autocomplete=1")
		if err != nil {
			continue
		}

		defer fetchAddress.Body.Close()

		addressObject := make(map[string]interface{})
		err = json.NewDecoder(fetchAddress.Body).Decode(&addressObject)
		if err != nil {
			continue
		}

		features := addressObject["features"].([]interface{})
		if len(features) > 0 {
			properties := features[rand.Intn(len(features))].(map[string]interface{})["properties"].(map[string]interface{})
			postCode, _ := strconv.Atoi(properties["postcode"].(string))
			if checkInParis(postCode) {
				address = properties["label"].(string)
				break
			}
		}
	}

	return address
}

func checkInParis(postCode int) bool {
	parisPostCode := []int{93, 92, 91, 75, 77, 78}
	postCodeStr := strconv.Itoa(postCode)
	twoDigitsPostCode, _ := strconv.Atoi(postCodeStr[:2])
	return contains(parisPostCode, twoDigitsPostCode)
}

func contains(slice []int, item int) bool {
	for _, v := range slice {
		if v == item {
			return true
		}
	}
	return false
}
