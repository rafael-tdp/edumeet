package fixture

import (
	"context"
	"edumeet/ent"
	"edumeet/utils"
	"strings"

	"github.com/brianvoe/gofakeit/v7"
)

type User struct{}

func (u *User) GenerateUser(ctx context.Context, client *ent.Client) {
	physicalUser := []string{"Zaid", "Jugurtha", "Rafael", "Makan"}
	physicalAddress := []string{"242 Rue du Faubourg Saint-Antoine, 75012 Paris", "105 Stoke Newington Church St, London N16 0UD, Royaume-Uni", "44 Rue des Clottins, 95560 Montsoult", "14 Rue Édouard-Grimaux, 86000 Poitiers"}
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
		lat, lng, err := utils.GetLatLng(physicalAddress[i])
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
			SetAddress(physicalAddress[i]).
			SetLng(lng).
			SetLat(lat).
			SetCreatedBy(id).
			SetUpdatedBy(id).
			SetPicture(pictures[gofakeit.Number(0, len(pictures)-1)]).
			SaveX(ctx)
	}
}
