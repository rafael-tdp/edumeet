// Code generated by ent, DO NOT EDIT.

package participant

import (
	"time"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
)

const (
	// Label holds the string label denoting the participant type in the database.
	Label = "participant"
	// FieldID holds the string denoting the id field in the database.
	FieldID = "id"
	// FieldStatus holds the string denoting the status field in the database.
	FieldStatus = "status"
	// FieldRequestedAt holds the string denoting the requested_at field in the database.
	FieldRequestedAt = "requested_at"
	// FieldJoinedAt holds the string denoting the joined_at field in the database.
	FieldJoinedAt = "joined_at"
	// EdgeUser holds the string denoting the user edge name in mutations.
	EdgeUser = "user"
	// EdgeEvent holds the string denoting the event edge name in mutations.
	EdgeEvent = "event"
	// Table holds the table name of the participant in the database.
	Table = "participants"
	// UserTable is the table that holds the user relation/edge.
	UserTable = "participants"
	// UserInverseTable is the table name for the User entity.
	// It exists in this package in order to avoid circular dependency with the "user" package.
	UserInverseTable = "users"
	// UserColumn is the table column denoting the user relation/edge.
	UserColumn = "user_participants"
	// EventTable is the table that holds the event relation/edge.
	EventTable = "participants"
	// EventInverseTable is the table name for the Event entity.
	// It exists in this package in order to avoid circular dependency with the "event" package.
	EventInverseTable = "events"
	// EventColumn is the table column denoting the event relation/edge.
	EventColumn = "event_participants"
)

// Columns holds all SQL columns for participant fields.
var Columns = []string{
	FieldID,
	FieldStatus,
	FieldRequestedAt,
	FieldJoinedAt,
}

// ForeignKeys holds the SQL foreign-keys that are owned by the "participants"
// table and are not defined as standalone fields in the schema.
var ForeignKeys = []string{
	"event_participants",
	"user_participants",
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
	// DefaultRequestedAt holds the default value on creation for the "requested_at" field.
	DefaultRequestedAt func() time.Time
	// DefaultID holds the default value on creation for the "id" field.
	DefaultID func() string
)

// OrderOption defines the ordering options for the Participant queries.
type OrderOption func(*sql.Selector)

// ByID orders the results by the id field.
func ByID(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldID, opts...).ToFunc()
}

// ByStatus orders the results by the status field.
func ByStatus(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldStatus, opts...).ToFunc()
}

// ByRequestedAt orders the results by the requested_at field.
func ByRequestedAt(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldRequestedAt, opts...).ToFunc()
}

// ByJoinedAt orders the results by the joined_at field.
func ByJoinedAt(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldJoinedAt, opts...).ToFunc()
}

// ByUserField orders the results by user field.
func ByUserField(field string, opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newUserStep(), sql.OrderByField(field, opts...))
	}
}

// ByEventField orders the results by event field.
func ByEventField(field string, opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newEventStep(), sql.OrderByField(field, opts...))
	}
}
func newUserStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(UserInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.M2O, true, UserTable, UserColumn),
	)
}
func newEventStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(EventInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.M2O, true, EventTable, EventColumn),
	)
}
