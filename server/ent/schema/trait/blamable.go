package trait

import (
	"context"
	"edumeet/ent/hook"
	"flag"
	"fmt"
	"time"

	"entgo.io/ent"
	"entgo.io/ent/schema/field"
	"entgo.io/ent/schema/mixin"
)

type Blamable struct {
	mixin.Schema
}

func (Blamable) Fields() []ent.Field {
	return []ent.Field{
		field.Time("created_at").Default(time.Now),
		field.Time("updated_at").Default(time.Now).UpdateDefault(time.Now),
		field.String("created_by").Optional().Nillable(),
		field.String("updated_by").Optional().Nillable(),
	}
}

// Hooks définit un hook de mutation pour gérer les champs created_by et updated_by.
func (Blamable) Hooks() []ent.Hook {
	return []ent.Hook{
		hook.On(
			func(next ent.Mutator) ent.Mutator {
				return ent.MutateFunc(func(ctx context.Context, m ent.Mutation) (ent.Value, error) {
					if flag.Lookup("mode").Value.String() != "normal" || ctx.Value("user_id") == "register" {
						return next.Mutate(ctx, m)
					}
					// Récupérer l'ID de l'utilisateur dans le contexte
					userID, ok := ctx.Value("user_id").(string)
					if !ok {
						return nil, fmt.Errorf("user_id not found in context")
					}

					// Définir les champs created_by ou updated_by en fonction de l'opération
					if m.Op().Is(ent.OpCreate) {
						if err := m.SetField("created_by", userID); err != nil {
							return nil, err
						}
					} else if m.Op().Is(ent.OpUpdate) || m.Op().Is(ent.OpUpdateOne) {
						if err := m.SetField("updated_by", userID); err != nil {
							return nil, err
						}
					}

					// Appeler le prochain mutateur dans la chaîne
					return next.Mutate(ctx, m)
				})
			},
			ent.OpCreate|ent.OpUpdate|ent.OpUpdateOne, // Appliquer uniquement pour CREATE et UPDATE
		),
	}
}
