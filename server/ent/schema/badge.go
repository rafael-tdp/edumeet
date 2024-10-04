package schema

import (
	"edumeet/utils"

	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

type Badge struct {
	ent.Schema
}

func (Badge) Fields() []ent.Field {
	ulid := utils.ULID{}
	return []ent.Field{
		field.String("id").DefaultFunc(ulid.GenerateUlid()).Unique(),
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
