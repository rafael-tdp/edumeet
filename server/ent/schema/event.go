package schema

import (
	"edumeet/utils"

	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

type Event struct {
	ent.Schema
}

func (Event) Fields() []ent.Field {
	ulid := utils.ULID{}
	return []ent.Field{
		field.String("id").DefaultFunc(ulid.GenerateUlid()).Unique(),
		field.Int("nbMaxUser"),
		field.Time("start_date"),
		field.Time("end_date").Optional(),
		field.Bool("isPrivate").Default(false),
		field.String("title"),
		field.String("description").Optional(),
		field.String("invitationLink").Optional(),
	}
}

func (Event) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("user", User.Type).Ref("events").Unique(),
		edge.To("messages", Message.Type).Unique(),
		edge.To("event_documents", EventDocument.Type),
		edge.To("subjects", Subject.Type),
		edge.To("participants", Participant.Type),
		edge.To("remote_event", RemoteEvent.Type).Unique(),
		edge.To("physical_event", PhysicalEvent.Type).Unique(),
	}
}
