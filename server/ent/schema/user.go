package schema

import (
	"time"

	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"github.com/oklog/ulid/v2"
)

type User struct {
	ent.Schema
}

func (User) Fields() []ent.Field {
	return []ent.Field{
		field.String("id").Default(ulid.Make().String()),
		field.String("email").Unique(),
		field.String("username"),
		field.String("lastname"),
		field.String("firstname"),
		field.String("password").Sensitive(),
		field.Time("birthDate"),
		field.String("bio").Optional().Nillable(),
		field.String("picture").Optional().Nillable(),
		field.Bool("activated").Default(false),
		field.Int("reportNumber").Default(0),
		field.Float("lng").Optional().Nillable(),
		field.Float("lat").Optional().Nillable(),
		field.Time("created_at").Default(time.Now),
	}
}

func (User) Edges() []ent.Edge {
	return []ent.Edge{
		edge.To("badges", Badge.Type),
		edge.To("subjects", Subject.Type),
		edge.To("events", Event.Type),
		edge.To("messages", Message.Type),
		edge.To("reports", Reporting.Type),
		edge.To("participants", Participant.Type),
	}
}
