package schema

import (
	"edumeet/ent/schema/trait"
	"edumeet/utils"

	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

type Message struct {
	ent.Schema
}

func (Message) Mixin() []ent.Mixin {
	return []ent.Mixin{
		trait.Blamable{},
	}
}

func (Message) Fields() []ent.Field {
	ulid := utils.ULID{}
	return []ent.Field{
		field.String("id").DefaultFunc(ulid.GenerateUlid()).Unique(),
		field.String("content"),
	}
}

func (Message) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("user", User.Type).Ref("messages").Unique(),
		edge.From("event", Event.Type).Ref("messages").Unique(),
		edge.To("documents", Document.Type),
	}
}
