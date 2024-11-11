package schema

import (
	"edumeet/utils"
	"time"

	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

type Participant struct {
	ent.Schema
}

func (Participant) Fields() []ent.Field {
	ulid := utils.ULID{}
	return []ent.Field{
		field.String("id").DefaultFunc(ulid.GenerateUlid()).Unique(),
		field.String("status"),
		field.Time("requested_at").Default(time.Now),
		field.Time("joined_at").Optional(),
	}
}

func (Participant) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("user", User.Type).Ref("participants").Unique(),
		edge.From("event", Event.Type).Ref("participants").Unique(),
	}
}
