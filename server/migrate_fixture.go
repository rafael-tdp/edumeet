package main

import (
	"context"
	"edumeet/ent"
	"edumeet/fixture"
	"log"
	"os"

	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
	"github.com/sirupsen/logrus"
)

func migrateFixture() {
	err := godotenv.Load()
	if err != nil {
		logrus.Error("Error loading .env file: %v", err)
		log.Fatalf("Error loading .env file")
	}

	client, err := ent.Open("postgres", os.Getenv("DATABASE_URL"))
	if err != nil {
		logrus.Error("failed opening connection to PostgreSQL: %v", err)
		log.Fatalf("failed opening connection to PostgreSQL: %v", err)
	}
	defer client.Close()

	ctx := context.Background()

	client.User.Delete().ExecX(ctx)
	userFixture := fixture.User{}
	userFixture.GenerateUser(ctx, client)

	client.Badge.Delete().ExecX(ctx)
	badgeFixture := fixture.Badge{}
	badgeFixture.GenerateBadge(ctx, client)

	client.Subject.Delete().ExecX(ctx)
	subjectFixture := fixture.Subject{}
	subjectFixture.GenerateSubject(ctx, client)

	client.Event.Delete().ExecX(ctx)
	eventFixture := fixture.Event{}
	eventFixture.GenerateEvent(ctx, client)

	client.Participant.Delete().ExecX(ctx)
	participantFixture := fixture.Participant{}
	participantFixture.GenerateParticipant(ctx, client)

	client.Document.Delete().ExecX(ctx)
	documentFixture := fixture.Document{}
	documentFixture.GenerateDocument(ctx, client)

	client.EventDocument.Delete().ExecX(ctx)
	eventDocumentFixture := fixture.EventDocument{}
	eventDocumentFixture.GenerateEventDocument(ctx, client)

	client.Friendship.Delete().ExecX(ctx)
	friendshipFixture := fixture.FriendShip{}
	friendshipFixture.GenerateFriendship(ctx, client)

	client.Message.Delete().ExecX(ctx)
	messageFixture := fixture.Message{}
	messageFixture.GenerateMessagesForEvents(ctx, client)
	messageFixture.GenerateMessagesForFriends(ctx, client)

	eventFixture.AddSubject(ctx, client)
	userFixture.AddSubject(ctx, client)

	logrus.Info("Fixtures applied successfully.")
	log.Println("Fixtures applied successfully.")
}
