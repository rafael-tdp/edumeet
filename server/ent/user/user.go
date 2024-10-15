// Code generated by ent, DO NOT EDIT.

package user

import (
	"fmt"
	"time"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
)

const (
	// Label holds the string label denoting the user type in the database.
	Label = "user"
	// FieldID holds the string denoting the id field in the database.
	FieldID = "id"
	// FieldEmail holds the string denoting the email field in the database.
	FieldEmail = "email"
	// FieldUsername holds the string denoting the username field in the database.
	FieldUsername = "username"
	// FieldLastname holds the string denoting the lastname field in the database.
	FieldLastname = "lastname"
	// FieldFirstname holds the string denoting the firstname field in the database.
	FieldFirstname = "firstname"
	// FieldPassword holds the string denoting the password field in the database.
	FieldPassword = "password"
	// FieldBirthDate holds the string denoting the birthdate field in the database.
	FieldBirthDate = "birth_date"
	// FieldBio holds the string denoting the bio field in the database.
	FieldBio = "bio"
	// FieldPicture holds the string denoting the picture field in the database.
	FieldPicture = "picture"
	// FieldActivated holds the string denoting the activated field in the database.
	FieldActivated = "activated"
	// FieldReportNumber holds the string denoting the reportnumber field in the database.
	FieldReportNumber = "report_number"
	// FieldLng holds the string denoting the lng field in the database.
	FieldLng = "lng"
	// FieldLat holds the string denoting the lat field in the database.
	FieldLat = "lat"
	// FieldCreatedAt holds the string denoting the created_at field in the database.
	FieldCreatedAt = "created_at"
	// FieldCode holds the string denoting the code field in the database.
	FieldCode = "code"
	// FieldRole holds the string denoting the role field in the database.
	FieldRole = "role"
	// EdgeBadges holds the string denoting the badges edge name in mutations.
	EdgeBadges = "badges"
	// EdgeSubjects holds the string denoting the subjects edge name in mutations.
	EdgeSubjects = "subjects"
	// EdgeEvents holds the string denoting the events edge name in mutations.
	EdgeEvents = "events"
	// EdgeMessages holds the string denoting the messages edge name in mutations.
	EdgeMessages = "messages"
	// EdgeReports holds the string denoting the reports edge name in mutations.
	EdgeReports = "reports"
	// EdgeParticipants holds the string denoting the participants edge name in mutations.
	EdgeParticipants = "participants"
	// Table holds the table name of the user in the database.
	Table = "users"
	// BadgesTable is the table that holds the badges relation/edge. The primary key declared below.
	BadgesTable = "user_badges"
	// BadgesInverseTable is the table name for the Badge entity.
	// It exists in this package in order to avoid circular dependency with the "badge" package.
	BadgesInverseTable = "badges"
	// SubjectsTable is the table that holds the subjects relation/edge. The primary key declared below.
	SubjectsTable = "user_subjects"
	// SubjectsInverseTable is the table name for the Subject entity.
	// It exists in this package in order to avoid circular dependency with the "subject" package.
	SubjectsInverseTable = "subjects"
	// EventsTable is the table that holds the events relation/edge.
	EventsTable = "events"
	// EventsInverseTable is the table name for the Event entity.
	// It exists in this package in order to avoid circular dependency with the "event" package.
	EventsInverseTable = "events"
	// EventsColumn is the table column denoting the events relation/edge.
	EventsColumn = "user_events"
	// MessagesTable is the table that holds the messages relation/edge.
	MessagesTable = "messages"
	// MessagesInverseTable is the table name for the Message entity.
	// It exists in this package in order to avoid circular dependency with the "message" package.
	MessagesInverseTable = "messages"
	// MessagesColumn is the table column denoting the messages relation/edge.
	MessagesColumn = "user_messages"
	// ReportsTable is the table that holds the reports relation/edge.
	ReportsTable = "reportings"
	// ReportsInverseTable is the table name for the Reporting entity.
	// It exists in this package in order to avoid circular dependency with the "reporting" package.
	ReportsInverseTable = "reportings"
	// ReportsColumn is the table column denoting the reports relation/edge.
	ReportsColumn = "user_reports"
	// ParticipantsTable is the table that holds the participants relation/edge.
	ParticipantsTable = "participants"
	// ParticipantsInverseTable is the table name for the Participant entity.
	// It exists in this package in order to avoid circular dependency with the "participant" package.
	ParticipantsInverseTable = "participants"
	// ParticipantsColumn is the table column denoting the participants relation/edge.
	ParticipantsColumn = "user_participants"
)

// Columns holds all SQL columns for user fields.
var Columns = []string{
	FieldID,
	FieldEmail,
	FieldUsername,
	FieldLastname,
	FieldFirstname,
	FieldPassword,
	FieldBirthDate,
	FieldBio,
	FieldPicture,
	FieldActivated,
	FieldReportNumber,
	FieldLng,
	FieldLat,
	FieldCreatedAt,
	FieldCode,
	FieldRole,
}

var (
	// BadgesPrimaryKey and BadgesColumn2 are the table columns denoting the
	// primary key for the badges relation (M2M).
	BadgesPrimaryKey = []string{"user_id", "badge_id"}
	// SubjectsPrimaryKey and SubjectsColumn2 are the table columns denoting the
	// primary key for the subjects relation (M2M).
	SubjectsPrimaryKey = []string{"user_id", "subject_id"}
)

// ValidColumn reports if the column name is valid (part of the table columns).
func ValidColumn(column string) bool {
	for i := range Columns {
		if column == Columns[i] {
			return true
		}
	}
	return false
}

var (
	// DefaultActivated holds the default value on creation for the "activated" field.
	DefaultActivated bool
	// DefaultReportNumber holds the default value on creation for the "reportNumber" field.
	DefaultReportNumber int
	// DefaultCreatedAt holds the default value on creation for the "created_at" field.
	DefaultCreatedAt func() time.Time
	// DefaultID holds the default value on creation for the "id" field.
	DefaultID func() string
)

// Role defines the type for the "role" enum field.
type Role string

// RoleUSER is the default value of the Role enum.
const DefaultRole = RoleUSER

// Role values.
const (
	RoleSUPERADMIN Role = "SUPER ADMIN"
	RoleADMIN      Role = "ADMIN"
	RoleUSER       Role = "USER"
)

func (r Role) String() string {
	return string(r)
}

// RoleValidator is a validator for the "role" field enum values. It is called by the builders before save.
func RoleValidator(r Role) error {
	switch r {
	case RoleSUPERADMIN, RoleADMIN, RoleUSER:
		return nil
	default:
		return fmt.Errorf("user: invalid enum value for role field: %q", r)
	}
}

// OrderOption defines the ordering options for the User queries.
type OrderOption func(*sql.Selector)

// ByID orders the results by the id field.
func ByID(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldID, opts...).ToFunc()
}

// ByEmail orders the results by the email field.
func ByEmail(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldEmail, opts...).ToFunc()
}

// ByUsername orders the results by the username field.
func ByUsername(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldUsername, opts...).ToFunc()
}

// ByLastname orders the results by the lastname field.
func ByLastname(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldLastname, opts...).ToFunc()
}

// ByFirstname orders the results by the firstname field.
func ByFirstname(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldFirstname, opts...).ToFunc()
}

// ByPassword orders the results by the password field.
func ByPassword(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldPassword, opts...).ToFunc()
}

// ByBirthDate orders the results by the birthDate field.
func ByBirthDate(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldBirthDate, opts...).ToFunc()
}

// ByBio orders the results by the bio field.
func ByBio(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldBio, opts...).ToFunc()
}

// ByPicture orders the results by the picture field.
func ByPicture(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldPicture, opts...).ToFunc()
}

// ByActivated orders the results by the activated field.
func ByActivated(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldActivated, opts...).ToFunc()
}

// ByReportNumber orders the results by the reportNumber field.
func ByReportNumber(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldReportNumber, opts...).ToFunc()
}

// ByLng orders the results by the lng field.
func ByLng(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldLng, opts...).ToFunc()
}

// ByLat orders the results by the lat field.
func ByLat(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldLat, opts...).ToFunc()
}

// ByCreatedAt orders the results by the created_at field.
func ByCreatedAt(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldCreatedAt, opts...).ToFunc()
}

// ByCode orders the results by the code field.
func ByCode(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldCode, opts...).ToFunc()
}

// ByRole orders the results by the role field.
func ByRole(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldRole, opts...).ToFunc()
}

// ByBadgesCount orders the results by badges count.
func ByBadgesCount(opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborsCount(s, newBadgesStep(), opts...)
	}
}

// ByBadges orders the results by badges terms.
func ByBadges(term sql.OrderTerm, terms ...sql.OrderTerm) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newBadgesStep(), append([]sql.OrderTerm{term}, terms...)...)
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

// ByEventsCount orders the results by events count.
func ByEventsCount(opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborsCount(s, newEventsStep(), opts...)
	}
}

// ByEvents orders the results by events terms.
func ByEvents(term sql.OrderTerm, terms ...sql.OrderTerm) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newEventsStep(), append([]sql.OrderTerm{term}, terms...)...)
	}
}

// ByMessagesCount orders the results by messages count.
func ByMessagesCount(opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborsCount(s, newMessagesStep(), opts...)
	}
}

// ByMessages orders the results by messages terms.
func ByMessages(term sql.OrderTerm, terms ...sql.OrderTerm) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newMessagesStep(), append([]sql.OrderTerm{term}, terms...)...)
	}
}

// ByReportsCount orders the results by reports count.
func ByReportsCount(opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborsCount(s, newReportsStep(), opts...)
	}
}

// ByReports orders the results by reports terms.
func ByReports(term sql.OrderTerm, terms ...sql.OrderTerm) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newReportsStep(), append([]sql.OrderTerm{term}, terms...)...)
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
func newBadgesStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(BadgesInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.M2M, false, BadgesTable, BadgesPrimaryKey...),
	)
}
func newSubjectsStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(SubjectsInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.M2M, false, SubjectsTable, SubjectsPrimaryKey...),
	)
}
func newEventsStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(EventsInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.O2M, false, EventsTable, EventsColumn),
	)
}
func newMessagesStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(MessagesInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.O2M, false, MessagesTable, MessagesColumn),
	)
}
func newReportsStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(ReportsInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.O2M, false, ReportsTable, ReportsColumn),
	)
}
func newParticipantsStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(ParticipantsInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.O2M, false, ParticipantsTable, ParticipantsColumn),
	)
}