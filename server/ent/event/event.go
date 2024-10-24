// Code generated by ent, DO NOT EDIT.

package event

import (
	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
)

const (
	// Label holds the string label denoting the event type in the database.
	Label = "event"
	// FieldID holds the string denoting the id field in the database.
	FieldID = "id"
	// FieldNbMaxUser holds the string denoting the nbmaxuser field in the database.
	FieldNbMaxUser = "nb_max_user"
	// FieldStartDate holds the string denoting the start_date field in the database.
	FieldStartDate = "start_date"
	// FieldEndDate holds the string denoting the end_date field in the database.
	FieldEndDate = "end_date"
	// FieldIsPrivate holds the string denoting the isprivate field in the database.
	FieldIsPrivate = "is_private"
	// FieldTitle holds the string denoting the title field in the database.
	FieldTitle = "title"
	// FieldDescription holds the string denoting the description field in the database.
	FieldDescription = "description"
	// FieldInvitationLink holds the string denoting the invitationlink field in the database.
	FieldInvitationLink = "invitation_link"
	// EdgeUser holds the string denoting the user edge name in mutations.
	EdgeUser = "user"
	// EdgeMessages holds the string denoting the messages edge name in mutations.
	EdgeMessages = "messages"
	// EdgeEventDocuments holds the string denoting the event_documents edge name in mutations.
	EdgeEventDocuments = "event_documents"
	// EdgeSubjects holds the string denoting the subjects edge name in mutations.
	EdgeSubjects = "subjects"
	// EdgeParticipants holds the string denoting the participants edge name in mutations.
	EdgeParticipants = "participants"
	// EdgeRemoteEvent holds the string denoting the remote_event edge name in mutations.
	EdgeRemoteEvent = "remote_event"
	// EdgePhysicalEvent holds the string denoting the physical_event edge name in mutations.
	EdgePhysicalEvent = "physical_event"
	// Table holds the table name of the event in the database.
	Table = "events"
	// UserTable is the table that holds the user relation/edge.
	UserTable = "events"
	// UserInverseTable is the table name for the User entity.
	// It exists in this package in order to avoid circular dependency with the "user" package.
	UserInverseTable = "users"
	// UserColumn is the table column denoting the user relation/edge.
	UserColumn = "user_events"
	// MessagesTable is the table that holds the messages relation/edge.
	MessagesTable = "messages"
	// MessagesInverseTable is the table name for the Message entity.
	// It exists in this package in order to avoid circular dependency with the "message" package.
	MessagesInverseTable = "messages"
	// MessagesColumn is the table column denoting the messages relation/edge.
	MessagesColumn = "event_messages"
	// EventDocumentsTable is the table that holds the event_documents relation/edge.
	EventDocumentsTable = "event_documents"
	// EventDocumentsInverseTable is the table name for the EventDocument entity.
	// It exists in this package in order to avoid circular dependency with the "eventdocument" package.
	EventDocumentsInverseTable = "event_documents"
	// EventDocumentsColumn is the table column denoting the event_documents relation/edge.
	EventDocumentsColumn = "event_event_documents"
	// SubjectsTable is the table that holds the subjects relation/edge. The primary key declared below.
	SubjectsTable = "event_subjects"
	// SubjectsInverseTable is the table name for the Subject entity.
	// It exists in this package in order to avoid circular dependency with the "subject" package.
	SubjectsInverseTable = "subjects"
	// ParticipantsTable is the table that holds the participants relation/edge.
	ParticipantsTable = "participants"
	// ParticipantsInverseTable is the table name for the Participant entity.
	// It exists in this package in order to avoid circular dependency with the "participant" package.
	ParticipantsInverseTable = "participants"
	// ParticipantsColumn is the table column denoting the participants relation/edge.
	ParticipantsColumn = "event_participants"
	// RemoteEventTable is the table that holds the remote_event relation/edge.
	RemoteEventTable = "remote_events"
	// RemoteEventInverseTable is the table name for the RemoteEvent entity.
	// It exists in this package in order to avoid circular dependency with the "remoteevent" package.
	RemoteEventInverseTable = "remote_events"
	// RemoteEventColumn is the table column denoting the remote_event relation/edge.
	RemoteEventColumn = "event_remote_event"
	// PhysicalEventTable is the table that holds the physical_event relation/edge.
	PhysicalEventTable = "physical_events"
	// PhysicalEventInverseTable is the table name for the PhysicalEvent entity.
	// It exists in this package in order to avoid circular dependency with the "physicalevent" package.
	PhysicalEventInverseTable = "physical_events"
	// PhysicalEventColumn is the table column denoting the physical_event relation/edge.
	PhysicalEventColumn = "event_physical_event"
)

// Columns holds all SQL columns for event fields.
var Columns = []string{
	FieldID,
	FieldNbMaxUser,
	FieldStartDate,
	FieldEndDate,
	FieldIsPrivate,
	FieldTitle,
	FieldDescription,
	FieldInvitationLink,
}

// ForeignKeys holds the SQL foreign-keys that are owned by the "events"
// table and are not defined as standalone fields in the schema.
var ForeignKeys = []string{
	"user_events",
}

var (
	// SubjectsPrimaryKey and SubjectsColumn2 are the table columns denoting the
	// primary key for the subjects relation (M2M).
	SubjectsPrimaryKey = []string{"event_id", "subject_id"}
)

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
	// DefaultIsPrivate holds the default value on creation for the "isPrivate" field.
	DefaultIsPrivate bool
	// DefaultID holds the default value on creation for the "id" field.
	DefaultID func() string
)

// OrderOption defines the ordering options for the Event queries.
type OrderOption func(*sql.Selector)

// ByID orders the results by the id field.
func ByID(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldID, opts...).ToFunc()
}

// ByNbMaxUser orders the results by the nbMaxUser field.
func ByNbMaxUser(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldNbMaxUser, opts...).ToFunc()
}

// ByStartDate orders the results by the start_date field.
func ByStartDate(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldStartDate, opts...).ToFunc()
}

// ByEndDate orders the results by the end_date field.
func ByEndDate(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldEndDate, opts...).ToFunc()
}

// ByIsPrivate orders the results by the isPrivate field.
func ByIsPrivate(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldIsPrivate, opts...).ToFunc()
}

// ByTitle orders the results by the title field.
func ByTitle(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldTitle, opts...).ToFunc()
}

// ByDescription orders the results by the description field.
func ByDescription(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldDescription, opts...).ToFunc()
}

// ByInvitationLink orders the results by the invitationLink field.
func ByInvitationLink(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldInvitationLink, opts...).ToFunc()
}

// ByUserField orders the results by user field.
func ByUserField(field string, opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newUserStep(), sql.OrderByField(field, opts...))
	}
}

// ByMessagesField orders the results by messages field.
func ByMessagesField(field string, opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newMessagesStep(), sql.OrderByField(field, opts...))
	}
}

// ByEventDocumentsCount orders the results by event_documents count.
func ByEventDocumentsCount(opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborsCount(s, newEventDocumentsStep(), opts...)
	}
}

// ByEventDocuments orders the results by event_documents terms.
func ByEventDocuments(term sql.OrderTerm, terms ...sql.OrderTerm) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newEventDocumentsStep(), append([]sql.OrderTerm{term}, terms...)...)
	}
}

// BySubjectsCount orders the results by subjects count.
func BySubjectsCount(opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborsCount(s, newSubjectsStep(), opts...)
	}
}

// BySubjects orders the results by subjects terms.
func BySubjects(term sql.OrderTerm, terms ...sql.OrderTerm) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newSubjectsStep(), append([]sql.OrderTerm{term}, terms...)...)
	}
}

// ByParticipantsCount orders the results by participants count.
func ByParticipantsCount(opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborsCount(s, newParticipantsStep(), opts...)
	}
}

// ByParticipants orders the results by participants terms.
func ByParticipants(term sql.OrderTerm, terms ...sql.OrderTerm) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newParticipantsStep(), append([]sql.OrderTerm{term}, terms...)...)
	}
}

// ByRemoteEventField orders the results by remote_event field.
func ByRemoteEventField(field string, opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newRemoteEventStep(), sql.OrderByField(field, opts...))
	}
}

// ByPhysicalEventField orders the results by physical_event field.
func ByPhysicalEventField(field string, opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newPhysicalEventStep(), sql.OrderByField(field, opts...))
	}
}
func newUserStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(UserInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.M2O, true, UserTable, UserColumn),
	)
}
func newMessagesStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(MessagesInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.O2O, false, MessagesTable, MessagesColumn),
	)
}
func newEventDocumentsStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(EventDocumentsInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.O2M, false, EventDocumentsTable, EventDocumentsColumn),
	)
}
func newSubjectsStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(SubjectsInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.M2M, false, SubjectsTable, SubjectsPrimaryKey...),
	)
}
func newParticipantsStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(ParticipantsInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.O2M, false, ParticipantsTable, ParticipantsColumn),
	)
}
func newRemoteEventStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(RemoteEventInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.O2O, false, RemoteEventTable, RemoteEventColumn),
	)
}
func newPhysicalEventStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(PhysicalEventInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.O2O, false, PhysicalEventTable, PhysicalEventColumn),
	)
}
