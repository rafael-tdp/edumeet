// Code generated by ent, DO NOT EDIT.

package physicalevent

import (
	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
)

const (
	// Label holds the string label denoting the physicalevent type in the database.
	Label = "physical_event"
	// FieldID holds the string denoting the id field in the database.
	FieldID = "id"
	// FieldLng holds the string denoting the lng field in the database.
	FieldLng = "lng"
	// FieldLat holds the string denoting the lat field in the database.
	FieldLat = "lat"
	// FieldLocation holds the string denoting the location field in the database.
	FieldLocation = "location"
	// EdgeEvent holds the string denoting the event edge name in mutations.
	EdgeEvent = "event"
	// Table holds the table name of the physicalevent in the database.
	Table = "physical_events"
	// EventTable is the table that holds the event relation/edge.
	EventTable = "physical_events"
	// EventInverseTable is the table name for the Event entity.
	// It exists in this package in order to avoid circular dependency with the "event" package.
	EventInverseTable = "events"
	// EventColumn is the table column denoting the event relation/edge.
	EventColumn = "event_physical_event"
)

// Columns holds all SQL columns for physicalevent fields.
var Columns = []string{
	FieldID,
	FieldLng,
	FieldLat,
	FieldLocation,
}

// ForeignKeys holds the SQL foreign-keys that are owned by the "physical_events"
// table and are not defined as standalone fields in the schema.
var ForeignKeys = []string{
	"event_physical_event",
}

// ValidColumn reports if the column name is valid (part of the table columns).
func ValidColumn(column string) bool {
	for i := range Columns {
		if column == Columns[i] {
			return true
		}
	}
	for i := range ForeignKeys {
		if column == ForeignKeys[i] {
			return true
		}
	}
	return false
}

var (
	// DefaultID holds the default value on creation for the "id" field.
	DefaultID func() string
)

// OrderOption defines the ordering options for the PhysicalEvent queries.
type OrderOption func(*sql.Selector)

// ByID orders the results by the id field.
func ByID(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldID, opts...).ToFunc()
}

// ByLng orders the results by the lng field.
func ByLng(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldLng, opts...).ToFunc()
}

// ByLat orders the results by the lat field.
func ByLat(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldLat, opts...).ToFunc()
}

// ByLocation orders the results by the location field.
func ByLocation(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldLocation, opts...).ToFunc()
}

// ByEventField orders the results by event field.
func ByEventField(field string, opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newEventStep(), sql.OrderByField(field, opts...))
	}
}
func newEventStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(EventInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.O2O, true, EventTable, EventColumn),
	)
}
