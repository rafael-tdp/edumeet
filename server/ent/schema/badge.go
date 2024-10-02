package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"github.com/oklog/ulid/v2"
)

type Badge struct {
	ent.Schema
}

func (Badge) Fields() []ent.Field {
	return []ent.Field{
		field.String("id").Default(ulid.Make().String()),
		field.String("name"),
		field.String("svg"),
		field.Int("nbRequirementEvent"),
		field.String("type"),
	}
}

func (Badge) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("users", User.Type).
			Ref("badges"),
	}
}
