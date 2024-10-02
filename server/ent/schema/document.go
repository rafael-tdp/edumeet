package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"github.com/oklog/ulid/v2"
)

type Document struct {
	ent.Schema
}

func (Document) Fields() []ent.Field {
	return []ent.Field{
		field.String("id").Default(ulid.Make().String()),
		field.String("path"),
	}
}

func (Document) Edges() []ent.Edge {
	return []ent.Edge{
		edge.To("event_documents", EventDocument.Type),
		edge.From("message", Message.Type).Ref("documents"),
	}
}
