package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"github.com/oklog/ulid/v2"
)

type Subject struct {
	ent.Schema
}

func (Subject) Fields() []ent.Field {
	return []ent.Field{
		field.String("id").Default(ulid.Make().String()),
		field.String("name"),
	}
}

func (Subject) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("users", User.Type).Ref("subjects"),
		edge.From("events", Event.Type).Ref("subjects"),
	}
}
