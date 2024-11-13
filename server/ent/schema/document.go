package schema

import (
	"edumeet/ent/schema/trait"
	"edumeet/utils"

	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

type Document struct {
	ent.Schema
}

func (Document) Fields() []ent.Field {
	ulid := utils.ULID{}
	return append(
		trait.Blamable{}.Fields(),
		[]ent.Field{
			field.String("id").DefaultFunc(ulid.GenerateUlid()).Unique(),
			field.String("path"),
		}...,
	)
}

func (Document) Edges() []ent.Edge {
	return []ent.Edge{
		edge.To("event_documents", EventDocument.Type),
		edge.From("message", Message.Type).Ref("documents"),
	}
}
