package schema

import (
	"time"

	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"github.com/oklog/ulid/v2"
)

type Message struct {
	ent.Schema
}

func (Message) Fields() []ent.Field {
	return []ent.Field{
		field.String("id").Default(ulid.Make().String()),
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
