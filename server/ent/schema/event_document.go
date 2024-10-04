package schema

import (
	"edumeet/utils"

	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

type EventDocument struct {
	ent.Schema
}

func (EventDocument) Fields() []ent.Field {
	ulid := utils.ULID{}
	return []ent.Field{
		field.String("id").DefaultFunc(ulid.GenerateUlid()).Unique(),
		field.String("type"),
	}
}

func (EventDocument) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("document", Document.Type).Ref("event_documents").Unique(),
		edge.From("event", Event.Type).Ref("event_documents").Unique(),
	}
}
