package schema

import (
	"edumeet/utils"

	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

type Subject struct {
	ent.Schema
}

func (Subject) Fields() []ent.Field {
	ulid := utils.ULID{}
	return []ent.Field{
		field.String("id").DefaultFunc(ulid.GenerateUlid()).Unique(),
		field.String("name"),
	}
}

func (Subject) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("users", User.Type).Ref("subjects"),
		edge.From("events", Event.Type).Ref("subjects"),
	}
}
