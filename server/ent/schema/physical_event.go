package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

type PhysicalEvent struct {
	ent.Schema
}

func (PhysicalEvent) Fields() []ent.Field {
	return []ent.Field{
		field.Float("lng"),
		field.Float("lat"),
		field.String("location"),
	}
}

func (PhysicalEvent) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("event", Event.Type).Ref("physical_event").Unique(),
	}
}
