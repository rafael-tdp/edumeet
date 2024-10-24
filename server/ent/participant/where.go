// Code generated by ent, DO NOT EDIT.

package participant

import (
	"edumeet/ent/predicate"
	"time"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
)

// ID filters vertices based on their ID field.
func ID(id string) predicate.Participant {
	return predicate.Participant(sql.FieldEQ(FieldID, id))
}

// IDEQ applies the EQ predicate on the ID field.
func IDEQ(id string) predicate.Participant {
	return predicate.Participant(sql.FieldEQ(FieldID, id))
}

// IDNEQ applies the NEQ predicate on the ID field.
func IDNEQ(id string) predicate.Participant {
	return predicate.Participant(sql.FieldNEQ(FieldID, id))
}

// IDIn applies the In predicate on the ID field.
func IDIn(ids ...string) predicate.Participant {
	return predicate.Participant(sql.FieldIn(FieldID, ids...))
}

// IDNotIn applies the NotIn predicate on the ID field.
func IDNotIn(ids ...string) predicate.Participant {
	return predicate.Participant(sql.FieldNotIn(FieldID, ids...))
}

// IDGT applies the GT predicate on the ID field.
func IDGT(id string) predicate.Participant {
	return predicate.Participant(sql.FieldGT(FieldID, id))
}

// IDGTE applies the GTE predicate on the ID field.
func IDGTE(id string) predicate.Participant {
	return predicate.Participant(sql.FieldGTE(FieldID, id))
}

// IDLT applies the LT predicate on the ID field.
func IDLT(id string) predicate.Participant {
	return predicate.Participant(sql.FieldLT(FieldID, id))
}

// IDLTE applies the LTE predicate on the ID field.
func IDLTE(id string) predicate.Participant {
	return predicate.Participant(sql.FieldLTE(FieldID, id))
}

// IDEqualFold applies the EqualFold predicate on the ID field.
func IDEqualFold(id string) predicate.Participant {
	return predicate.Participant(sql.FieldEqualFold(FieldID, id))
}

// IDContainsFold applies the ContainsFold predicate on the ID field.
func IDContainsFold(id string) predicate.Participant {
	return predicate.Participant(sql.FieldContainsFold(FieldID, id))
}

// Status applies equality check predicate on the "status" field. It's identical to StatusEQ.
func Status(v string) predicate.Participant {
	return predicate.Participant(sql.FieldEQ(FieldStatus, v))
}

// RequestedAt applies equality check predicate on the "requested_at" field. It's identical to RequestedAtEQ.
func RequestedAt(v time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldEQ(FieldRequestedAt, v))
}

// JoinedAt applies equality check predicate on the "joined_at" field. It's identical to JoinedAtEQ.
func JoinedAt(v time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldEQ(FieldJoinedAt, v))
}

// StatusEQ applies the EQ predicate on the "status" field.
func StatusEQ(v string) predicate.Participant {
	return predicate.Participant(sql.FieldEQ(FieldStatus, v))
}

// StatusNEQ applies the NEQ predicate on the "status" field.
func StatusNEQ(v string) predicate.Participant {
	return predicate.Participant(sql.FieldNEQ(FieldStatus, v))
}

// StatusIn applies the In predicate on the "status" field.
func StatusIn(vs ...string) predicate.Participant {
	return predicate.Participant(sql.FieldIn(FieldStatus, vs...))
}

// StatusNotIn applies the NotIn predicate on the "status" field.
func StatusNotIn(vs ...string) predicate.Participant {
	return predicate.Participant(sql.FieldNotIn(FieldStatus, vs...))
}

// StatusGT applies the GT predicate on the "status" field.
func StatusGT(v string) predicate.Participant {
	return predicate.Participant(sql.FieldGT(FieldStatus, v))
}

// StatusGTE applies the GTE predicate on the "status" field.
func StatusGTE(v string) predicate.Participant {
	return predicate.Participant(sql.FieldGTE(FieldStatus, v))
}

// StatusLT applies the LT predicate on the "status" field.
func StatusLT(v string) predicate.Participant {
	return predicate.Participant(sql.FieldLT(FieldStatus, v))
}

// StatusLTE applies the LTE predicate on the "status" field.
func StatusLTE(v string) predicate.Participant {
	return predicate.Participant(sql.FieldLTE(FieldStatus, v))
}

// StatusContains applies the Contains predicate on the "status" field.
func StatusContains(v string) predicate.Participant {
	return predicate.Participant(sql.FieldContains(FieldStatus, v))
}

// StatusHasPrefix applies the HasPrefix predicate on the "status" field.
func StatusHasPrefix(v string) predicate.Participant {
	return predicate.Participant(sql.FieldHasPrefix(FieldStatus, v))
}

// StatusHasSuffix applies the HasSuffix predicate on the "status" field.
func StatusHasSuffix(v string) predicate.Participant {
	return predicate.Participant(sql.FieldHasSuffix(FieldStatus, v))
}

// StatusEqualFold applies the EqualFold predicate on the "status" field.
func StatusEqualFold(v string) predicate.Participant {
	return predicate.Participant(sql.FieldEqualFold(FieldStatus, v))
}

// StatusContainsFold applies the ContainsFold predicate on the "status" field.
func StatusContainsFold(v string) predicate.Participant {
	return predicate.Participant(sql.FieldContainsFold(FieldStatus, v))
}

// RequestedAtEQ applies the EQ predicate on the "requested_at" field.
func RequestedAtEQ(v time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldEQ(FieldRequestedAt, v))
}

// RequestedAtNEQ applies the NEQ predicate on the "requested_at" field.
func RequestedAtNEQ(v time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldNEQ(FieldRequestedAt, v))
}

// RequestedAtIn applies the In predicate on the "requested_at" field.
func RequestedAtIn(vs ...time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldIn(FieldRequestedAt, vs...))
}

// RequestedAtNotIn applies the NotIn predicate on the "requested_at" field.
func RequestedAtNotIn(vs ...time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldNotIn(FieldRequestedAt, vs...))
}

// RequestedAtGT applies the GT predicate on the "requested_at" field.
func RequestedAtGT(v time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldGT(FieldRequestedAt, v))
}

// RequestedAtGTE applies the GTE predicate on the "requested_at" field.
func RequestedAtGTE(v time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldGTE(FieldRequestedAt, v))
}

// RequestedAtLT applies the LT predicate on the "requested_at" field.
func RequestedAtLT(v time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldLT(FieldRequestedAt, v))
}

// RequestedAtLTE applies the LTE predicate on the "requested_at" field.
func RequestedAtLTE(v time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldLTE(FieldRequestedAt, v))
}

// JoinedAtEQ applies the EQ predicate on the "joined_at" field.
func JoinedAtEQ(v time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldEQ(FieldJoinedAt, v))
}

// JoinedAtNEQ applies the NEQ predicate on the "joined_at" field.
func JoinedAtNEQ(v time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldNEQ(FieldJoinedAt, v))
}

// JoinedAtIn applies the In predicate on the "joined_at" field.
func JoinedAtIn(vs ...time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldIn(FieldJoinedAt, vs...))
}

// JoinedAtNotIn applies the NotIn predicate on the "joined_at" field.
func JoinedAtNotIn(vs ...time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldNotIn(FieldJoinedAt, vs...))
}

// JoinedAtGT applies the GT predicate on the "joined_at" field.
func JoinedAtGT(v time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldGT(FieldJoinedAt, v))
}

// JoinedAtGTE applies the GTE predicate on the "joined_at" field.
func JoinedAtGTE(v time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldGTE(FieldJoinedAt, v))
}

// JoinedAtLT applies the LT predicate on the "joined_at" field.
func JoinedAtLT(v time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldLT(FieldJoinedAt, v))
}

// JoinedAtLTE applies the LTE predicate on the "joined_at" field.
func JoinedAtLTE(v time.Time) predicate.Participant {
	return predicate.Participant(sql.FieldLTE(FieldJoinedAt, v))
}

// JoinedAtIsNil applies the IsNil predicate on the "joined_at" field.
func JoinedAtIsNil() predicate.Participant {
	return predicate.Participant(sql.FieldIsNull(FieldJoinedAt))
}

// JoinedAtNotNil applies the NotNil predicate on the "joined_at" field.
func JoinedAtNotNil() predicate.Participant {
	return predicate.Participant(sql.FieldNotNull(FieldJoinedAt))
}

// HasUser applies the HasEdge predicate on the "user" edge.
func HasUser() predicate.Participant {
	return predicate.Participant(func(s *sql.Selector) {
		step := sqlgraph.NewStep(
			sqlgraph.From(Table, FieldID),
			sqlgraph.Edge(sqlgraph.M2O, true, UserTable, UserColumn),
		)
		sqlgraph.HasNeighbors(s, step)
	})
}

// HasUserWith applies the HasEdge predicate on the "user" edge with a given conditions (other predicates).
func HasUserWith(preds ...predicate.User) predicate.Participant {
	return predicate.Participant(func(s *sql.Selector) {
		step := newUserStep()
		sqlgraph.HasNeighborsWith(s, step, func(s *sql.Selector) {
			for _, p := range preds {
				p(s)
			}
		})
	})
}

// HasEvent applies the HasEdge predicate on the "event" edge.
func HasEvent() predicate.Participant {
	return predicate.Participant(func(s *sql.Selector) {
		step := sqlgraph.NewStep(
			sqlgraph.From(Table, FieldID),
			sqlgraph.Edge(sqlgraph.M2O, true, EventTable, EventColumn),
		)
		sqlgraph.HasNeighbors(s, step)
	})
}

// HasEventWith applies the HasEdge predicate on the "event" edge with a given conditions (other predicates).
func HasEventWith(preds ...predicate.Event) predicate.Participant {
	return predicate.Participant(func(s *sql.Selector) {
		step := newEventStep()
		sqlgraph.HasNeighborsWith(s, step, func(s *sql.Selector) {
			for _, p := range preds {
				p(s)
			}
		})
	})
}

// And groups predicates with the AND operator between them.
func And(predicates ...predicate.Participant) predicate.Participant {
	return predicate.Participant(sql.AndPredicates(predicates...))
}

// Or groups predicates with the OR operator between them.
func Or(predicates ...predicate.Participant) predicate.Participant {
	return predicate.Participant(sql.OrPredicates(predicates...))
}

// Not applies the not operator on the given predicate.
func Not(p predicate.Participant) predicate.Participant {
	return predicate.Participant(sql.NotPredicates(p))
}
