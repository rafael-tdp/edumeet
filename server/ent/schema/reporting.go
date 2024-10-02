package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"github.com/oklog/ulid/v2"
)

type Reporting struct {
	ent.Schema
}

func (Reporting) Fields() []ent.Field {
	return []ent.Field{
		field.String("id").Default(ulid.Make().String()),
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
