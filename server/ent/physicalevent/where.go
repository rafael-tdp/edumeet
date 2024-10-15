// Code generated by ent, DO NOT EDIT.

package physicalevent

import (
	"edumeet/ent/predicate"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
)

// ID filters vertices based on their ID field.
func ID(id string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldEQ(FieldID, id))
}

// IDEQ applies the EQ predicate on the ID field.
func IDEQ(id string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldEQ(FieldID, id))
}

// IDNEQ applies the NEQ predicate on the ID field.
func IDNEQ(id string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldNEQ(FieldID, id))
}

// IDIn applies the In predicate on the ID field.
func IDIn(ids ...string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldIn(FieldID, ids...))
}

// IDNotIn applies the NotIn predicate on the ID field.
func IDNotIn(ids ...string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldNotIn(FieldID, ids...))
}

// IDGT applies the GT predicate on the ID field.
func IDGT(id string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldGT(FieldID, id))
}

// IDGTE applies the GTE predicate on the ID field.
func IDGTE(id string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldGTE(FieldID, id))
}

// IDLT applies the LT predicate on the ID field.
func IDLT(id string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldLT(FieldID, id))
}

// IDLTE applies the LTE predicate on the ID field.
func IDLTE(id string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldLTE(FieldID, id))
}

// IDEqualFold applies the EqualFold predicate on the ID field.
func IDEqualFold(id string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldEqualFold(FieldID, id))
}

// IDContainsFold applies the ContainsFold predicate on the ID field.
func IDContainsFold(id string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldContainsFold(FieldID, id))
}

// Lng applies equality check predicate on the "lng" field. It's identical to LngEQ.
func Lng(v float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldEQ(FieldLng, v))
}

// Lat applies equality check predicate on the "lat" field. It's identical to LatEQ.
func Lat(v float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldEQ(FieldLat, v))
}

// Location applies equality check predicate on the "location" field. It's identical to LocationEQ.
func Location(v string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldEQ(FieldLocation, v))
}

// LngEQ applies the EQ predicate on the "lng" field.
func LngEQ(v float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldEQ(FieldLng, v))
}

// LngNEQ applies the NEQ predicate on the "lng" field.
func LngNEQ(v float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldNEQ(FieldLng, v))
}

// LngIn applies the In predicate on the "lng" field.
func LngIn(vs ...float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldIn(FieldLng, vs...))
}

// LngNotIn applies the NotIn predicate on the "lng" field.
func LngNotIn(vs ...float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldNotIn(FieldLng, vs...))
}

// LngGT applies the GT predicate on the "lng" field.
func LngGT(v float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldGT(FieldLng, v))
}

// LngGTE applies the GTE predicate on the "lng" field.
func LngGTE(v float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldGTE(FieldLng, v))
}

// LngLT applies the LT predicate on the "lng" field.
func LngLT(v float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldLT(FieldLng, v))
}

// LngLTE applies the LTE predicate on the "lng" field.
func LngLTE(v float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldLTE(FieldLng, v))
}

// LatEQ applies the EQ predicate on the "lat" field.
func LatEQ(v float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldEQ(FieldLat, v))
}

// LatNEQ applies the NEQ predicate on the "lat" field.
func LatNEQ(v float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldNEQ(FieldLat, v))
}

// LatIn applies the In predicate on the "lat" field.
func LatIn(vs ...float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldIn(FieldLat, vs...))
}

// LatNotIn applies the NotIn predicate on the "lat" field.
func LatNotIn(vs ...float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldNotIn(FieldLat, vs...))
}

// LatGT applies the GT predicate on the "lat" field.
func LatGT(v float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldGT(FieldLat, v))
}

// LatGTE applies the GTE predicate on the "lat" field.
func LatGTE(v float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldGTE(FieldLat, v))
}

// LatLT applies the LT predicate on the "lat" field.
func LatLT(v float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldLT(FieldLat, v))
}

// LatLTE applies the LTE predicate on the "lat" field.
func LatLTE(v float64) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldLTE(FieldLat, v))
}

// LocationEQ applies the EQ predicate on the "location" field.
func LocationEQ(v string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldEQ(FieldLocation, v))
}

// LocationNEQ applies the NEQ predicate on the "location" field.
func LocationNEQ(v string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldNEQ(FieldLocation, v))
}

// LocationIn applies the In predicate on the "location" field.
func LocationIn(vs ...string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldIn(FieldLocation, vs...))
}

// LocationNotIn applies the NotIn predicate on the "location" field.
func LocationNotIn(vs ...string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldNotIn(FieldLocation, vs...))
}

// LocationGT applies the GT predicate on the "location" field.
func LocationGT(v string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldGT(FieldLocation, v))
}

// LocationGTE applies the GTE predicate on the "location" field.
func LocationGTE(v string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldGTE(FieldLocation, v))
}

// LocationLT applies the LT predicate on the "location" field.
func LocationLT(v string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldLT(FieldLocation, v))
}

// LocationLTE applies the LTE predicate on the "location" field.
func LocationLTE(v string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldLTE(FieldLocation, v))
}

// LocationContains applies the Contains predicate on the "location" field.
func LocationContains(v string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldContains(FieldLocation, v))
}

// LocationHasPrefix applies the HasPrefix predicate on the "location" field.
func LocationHasPrefix(v string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldHasPrefix(FieldLocation, v))
}

// LocationHasSuffix applies the HasSuffix predicate on the "location" field.
func LocationHasSuffix(v string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldHasSuffix(FieldLocation, v))
}

// LocationEqualFold applies the EqualFold predicate on the "location" field.
func LocationEqualFold(v string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldEqualFold(FieldLocation, v))
}

// LocationContainsFold applies the ContainsFold predicate on the "location" field.
func LocationContainsFold(v string) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.FieldContainsFold(FieldLocation, v))
}

// HasEvent applies the HasEdge predicate on the "event" edge.
func HasEvent() predicate.PhysicalEvent {
	return predicate.PhysicalEvent(func(s *sql.Selector) {
		step := sqlgraph.NewStep(
			sqlgraph.From(Table, FieldID),
			sqlgraph.Edge(sqlgraph.O2O, true, EventTable, EventColumn),
		)
		sqlgraph.HasNeighbors(s, step)
	})
}

// HasEventWith applies the HasEdge predicate on the "event" edge with a given conditions (other predicates).
func HasEventWith(preds ...predicate.Event) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(func(s *sql.Selector) {
		step := newEventStep()
		sqlgraph.HasNeighborsWith(s, step, func(s *sql.Selector) {
			for _, p := range preds {
				p(s)
			}
		})
	})
}

// And groups predicates with the AND operator between them.
func And(predicates ...predicate.PhysicalEvent) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.AndPredicates(predicates...))
}

// Or groups predicates with the OR operator between them.
func Or(predicates ...predicate.PhysicalEvent) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.OrPredicates(predicates...))
}

// Not applies the not operator on the given predicate.
func Not(p predicate.PhysicalEvent) predicate.PhysicalEvent {
	return predicate.PhysicalEvent(sql.NotPredicates(p))
}
