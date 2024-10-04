package schema

import (
	"edumeet/utils"

	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

type Reporting struct {
	ent.Schema
}

func (Reporting) Fields() []ent.Field {
	ulid := utils.ULID{}
	return []ent.Field{
		field.String("id").DefaultFunc(ulid.GenerateUlid()).Unique(),
		field.String("reason"),
		field.String("type"),
		field.String("entity_id"),
	}
}

func (Reporting) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("user", User.Type).Ref("reports").Unique(),
	}
}
