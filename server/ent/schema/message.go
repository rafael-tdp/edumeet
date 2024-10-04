package schema

import (
	"edumeet/utils"
	"time"

	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

type Message struct {
	ent.Schema
}

func (Message) Fields() []ent.Field {
	ulid := utils.ULID{}
	return []ent.Field{
		field.String("id").DefaultFunc(ulid.GenerateUlid()).Unique(),
		field.String("content"),
		field.Time("sent_at").Default(time.Now),
	}
}

func (Message) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("user", User.Type).Ref("messages").Unique(),
		edge.From("event", Event.Type).Ref("messages").Unique(),
		edge.To("documents", Document.Type),
	}
}
