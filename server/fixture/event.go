package fixture

import (
	"context"
	"edumeet/ent"
	"time"

	"github.com/brianvoe/gofakeit/v7"
)

type Event struct{}

func generateRandomStartEndDate() (time.Time, time.Time) {
	start := time.Now().AddDate(0, 0, gofakeit.Number(30, 60))
	end := start.AddDate(0, 0, 2)
	return start, end
}

func (e *Event) GenerateEvent(ctx context.Context, client *ent.Client) {

	images := []string{
		"https://images.unsplash.com/photo-1653203187698-530a34a80ba5?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGNvdXJzfGVufDB8fDB8fHwy",
		"https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y291cnN8ZW58MHx8MHx8fDI%3D",
		"https://images.unsplash.com/photo-1716348300558-c81409ed958a?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y291cnN8ZW58MHx8MHx8fDI%3D",
		"https://images.unsplash.com/photo-1670934265254-954bd96352ba?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8Y291cnN8ZW58MHx8MHx8fDI%3D",
	}

	for i := 0; i < 10; i++ {
		start, end := generateRandomStartEndDate()

		event, err := client.Event.Create().
			SetTitle(gofakeit.Name()).
			SetDescription(gofakeit.Sentence(10)).
			SetStartDate(start).
			SetEndDate(end).
			// SetIsPrivate(gofakeit.Bool()).
			SetImage(images[gofakeit.Number(0, len(images)-1)]).
			SetInvitationLink(gofakeit.URL()).
			SetCreatedBy(gofakeit.UUID()).
			Save(ctx)

		if err != nil {
			panic(err)
		}

		if gofakeit.Bool() {
			_, err = client.RemoteEvent.Create().
				SetURL(gofakeit.URL()).
				SetEventID(event.ID).
				Save(ctx)
		} else {
			_, err = client.PhysicalEvent.Create().
				SetEventID(event.ID).
				SetLocation(gofakeit.Address().Address).
				SetLng(gofakeit.Longitude()).
				SetLat(gofakeit.Latitude()).
				Save(ctx)
		}
	}
}
