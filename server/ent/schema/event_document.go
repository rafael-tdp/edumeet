package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"github.com/oklog/ulid/v2"
)

type EventDocument struct {
	ent.Schema
}

func (EventDocument) Fields() []ent.Field {
	return []ent.Field{
		field.String("id").Default(ulid.Make().String()),
		field.String("type"),
	}
}

func (EventDocument) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("document", Document.Type).Ref("event_documents").Unique(),
		edge.From("event", Event.Type).Ref("event_documents").Unique(),
	}
}
