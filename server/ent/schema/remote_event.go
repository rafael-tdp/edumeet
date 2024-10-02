package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

type RemoteEvent struct {
	ent.Schema
}

func (RemoteEvent) Fields() []ent.Field {
	return []ent.Field{
		field.String("url"),
	}
}

func (RemoteEvent) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("event", Event.Type).Ref("remote_event").Unique(),
	}
}
