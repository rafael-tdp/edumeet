package fixture

import (
	"context"
	"edumeet/ent"
	"edumeet/utils"
	"time"

	"github.com/brianvoe/gofakeit/v7"
	"github.com/samber/lo"
)

type Event struct{}

func generateRandomStartEndDate() (time.Time, time.Time) {
	now := time.Now()
	startDate := time.Date(now.Year()-1, 1, 1, 0, 0, 0, 0, time.UTC)
	maxDate := now.AddDate(0, 3, 0)

	randomStart := startDate.Add(time.Duration(gofakeit.Number(0, int(maxDate.Sub(startDate).Hours()/24))) * 24 * time.Hour)

	randomEnd := randomStart.Add(48 * time.Hour)

	return randomStart, randomEnd
}

func (e *Event) GenerateEvent(ctx context.Context, client *ent.Client) {

	userIDs, err := client.User.Query().IDs(ctx)
	if err != nil {
		panic("error fetching user ids to create events : " + err.Error())
	}

	if len(userIDs) == 0 {
		panic("No users found to create events")
	}

	images := []string{
		"https://images.unsplash.com/photo-1653203187698-530a34a80ba5?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGNvdXJzfGVufDB8fDB8fHwy",
		"https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y291cnN8ZW58MHx8MHx8fDI%3D",
		"https://images.unsplash.com/photo-1716348300558-c81409ed958a?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y291cnN8ZW58MHx8MHx8fDI%3D",
		"https://images.unsplash.com/photo-1670934265254-954bd96352ba?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8Y291cnN8ZW58MHx8MHx8fDI%3D",
	}

	for i := 0; i < 100; i++ {
		start, end := generateRandomStartEndDate()
		createdBy := userIDs[gofakeit.Number(0, len(userIDs)-1)]
		var address string
		for {
			address = GetRandomAddress()
			if address != "" {
				break
			}
		}
		lat, lng, err := utils.GetLatLng(address)
		event, err := client.Event.Create().
			SetTitle(gofakeit.Name()).
			SetDescription(gofakeit.Sentence(10)).
			SetStartDate(start).
			SetEndDate(end).
			// SetIsPrivate(gofakeit.Bool()).
			SetImage(images[gofakeit.Number(0, len(images)-1)]).
			SetCode(lo.RandomString(6, lo.LettersCharset)).
			SetCreatedBy(createdBy).
			Save(ctx)

		if err != nil {
			panic(err)
		}

		if gofakeit.Bool() {
			_, err = client.RemoteEvent.Create().
				SetURL(gofakeit.URL()).
				SetEventID(event.ID).
				Save(ctx)
			if err != nil {
				panic(err)
			}
		} else {
			_, err = client.PhysicalEvent.Create().
				SetEventID(event.ID).
				SetLocation(address).
				SetLng(lng).
				SetLat(lat).
				Save(ctx)
			if err != nil {
				panic(err)
			}
		}
	}
}

func (e *Event) AddSubject(ctx context.Context, client *ent.Client) {
	subjects := client.Subject.Query().AllX(ctx)

	events := client.Event.Query().AllX(ctx)

	for _, event := range events {
		for i := 0; i < gofakeit.Number(1, 3); i++ {
			_, err := event.Update().AddSubjects(subjects[gofakeit.Number(0, len(subjects)-1)]).Save(ctx)
			if err != nil {
			}
		}
	}

}
