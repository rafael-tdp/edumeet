package trait

import (
	"time"

	"entgo.io/ent"
	"entgo.io/ent/schema/field"
)

type Blamable struct{}

func (Blamable) Fields() []ent.Field {
	return []ent.Field{
		field.Time("created_at").Default(time.Now),
		field.Time("updated_at").Default(time.Now).UpdateDefault(time.Now),
		field.String("created_by"),
		field.String("updated_by"),
	}
}
