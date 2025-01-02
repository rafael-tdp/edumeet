package schema

import (
	"edumeet/enums"
	"edumeet/utils"

	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

type Friendship struct {
	ent.Schema
}

func (Friendship) Fields() []ent.Field {
	ulid := utils.ULID{}
	return []ent.Field{
		field.String("id").DefaultFunc(ulid.GenerateUlid()).Unique(),
		field.String("status").Default(string(enums.FriendPending)),
	}
}

func (Friendship) Edges() []ent.Edge {
	return []ent.Edge{
		edge.To("user", User.Type).Unique(),
		edge.From("friend", User.Type).Ref("friendships").Unique(),
		edge.To("messages", Message.Type),
	}
}
