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
		"https://images.unsplash.com/photo-1534308143481-c55f00be8bd7?q=80&w=2830&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
		"https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHx8Mg%3D%3D",
		"https://images.unsplash.com/photo-1543610892-0b1f7e6d8ac1?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cHJvZmlsZXxlbnwwfHwwfHx8Mg%3D%3D",
	}
	dateUtils := utils.Date{}
	bcryptUtils := utils.Bcrypt{}
	for i := 0; i < len(physicalUser); i++ {
		lat, lng, err := utils.GetLatLng(physicalAddress[i])
		if err != nil {
			panic(err)
		}
		client.User.Create().
			SetEmail(strings.ToLower(physicalUser[i]) + "@user.com").
			SetUsername(strings.ToLower(physicalUser[i])).
			SetLastname(strings.ToLower(gofakeit.LastName())).
			SetFirstname(strings.ToLower(physicalUser[i])).
			SetPassword(bcryptUtils.HashPassword("Password1234!!")).
			SetBirthDate(dateUtils.GenerateBirthDate()).
			SetBio(gofakeit.Sentence(10)).
			SetActivated(true).
			SetLng(lng).
			SetLat(lat).
			SetZipCode(gofakeit.Zip()).
			SetPicture(pictures[gofakeit.Number(0, len(pictures)-1)]).
			SaveX(ctx)
	}
}
