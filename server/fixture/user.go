package fixture

import (
	"context"
	"edumeet/ent"
	"edumeet/utils"
	"strings"

	"github.com/brianvoe/gofakeit/v7"
)

type User struct{}

func (u *User) GenerateFixture(ctx context.Context, client *ent.Client) {
	physicalUser := []string{"Zaid", "Jugurtha", "Rapahel", "Makan"}
	dateUtils := utils.Date{}
	bcryptUtils := utils.Bcrypt{}
	for i := 0; i < len(physicalUser); i++ {
		client.User.Create().
			SetEmail(strings.ToLower(physicalUser[i]) + "@user.com").
			SetUsername(strings.ToLower(physicalUser[i])).
			SetLastname(strings.ToLower(gofakeit.LastName())).
			SetFirstname(strings.ToLower(physicalUser[i])).
			SetPassword(bcryptUtils.HashPassword("Password1234!!")).
			SetBirthDate(dateUtils.GenerateBirthDate()).
			SetBio(gofakeit.Sentence(10)).
			SetActivated(true).
			SetLng(gofakeit.Longitude()).
			SetLat(gofakeit.Latitude()).
			SaveX(ctx)
	}
}
