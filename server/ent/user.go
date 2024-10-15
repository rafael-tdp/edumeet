// Code generated by ent, DO NOT EDIT.

package ent

import (
	"edumeet/ent/user"
	"fmt"
	"strings"
	"time"

	"entgo.io/ent"
	"entgo.io/ent/dialect/sql"
)

// User is the model entity for the User schema.
type User struct {
	config `json:"-"`
	// ID of the ent.
	ID string `json:"id,omitempty"`
	// Email holds the value of the "email" field.
	Email string `json:"email,omitempty"`
	// Username holds the value of the "username" field.
	Username string `json:"username,omitempty"`
	// Lastname holds the value of the "lastname" field.
	Lastname string `json:"lastname,omitempty"`
	// Firstname holds the value of the "firstname" field.
	Firstname string `json:"firstname,omitempty"`
	// Password holds the value of the "password" field.
	Password string `json:"-"`
	// BirthDate holds the value of the "birthDate" field.
	BirthDate time.Time `json:"birthDate,omitempty"`
	// Bio holds the value of the "bio" field.
	Bio *string `json:"bio,omitempty"`
	// Picture holds the value of the "picture" field.
	Picture *string `json:"picture,omitempty"`
	// Activated holds the value of the "activated" field.
	Activated bool `json:"activated,omitempty"`
	// ReportNumber holds the value of the "reportNumber" field.
	ReportNumber int `json:"reportNumber,omitempty"`
	// Lng holds the value of the "lng" field.
	Lng *float64 `json:"lng,omitempty"`
	// Lat holds the value of the "lat" field.
	Lat *float64 `json:"lat,omitempty"`
	// CreatedAt holds the value of the "created_at" field.
	CreatedAt time.Time `json:"created_at,omitempty"`
	// Code holds the value of the "code" field.
	Code *string `json:"code,omitempty"`
	// Role holds the value of the "role" field.
	Role user.Role `json:"role,omitempty"`
	// Edges holds the relations/edges for other nodes in the graph.
	// The values are being populated by the UserQuery when eager-loading is set.
	Edges        UserEdges `json:"edges"`
	selectValues sql.SelectValues
}

// UserEdges holds the relations/edges for other nodes in the graph.
type UserEdges struct {
	// Badges holds the value of the badges edge.
	Badges []*Badge `json:"badges,omitempty"`
	// Subjects holds the value of the subjects edge.
	Subjects []*Subject `json:"subjects,omitempty"`
	// Events holds the value of the events edge.
	Events []*Event `json:"events,omitempty"`
	// Messages holds the value of the messages edge.
	Messages []*Message `json:"messages,omitempty"`
	// Reports holds the value of the reports edge.
	Reports []*Reporting `json:"reports,omitempty"`
	// Participants holds the value of the participants edge.
	Participants []*Participant `json:"participants,omitempty"`
	// loadedTypes holds the information for reporting if a
	// type was loaded (or requested) in eager-loading or not.
	loadedTypes [6]bool
}

// BadgesOrErr returns the Badges value or an error if the edge
// was not loaded in eager-loading.
func (e UserEdges) BadgesOrErr() ([]*Badge, error) {
	if e.loadedTypes[0] {
		return e.Badges, nil
	}
	return nil, &NotLoadedError{edge: "badges"}
}

// SubjectsOrErr returns the Subjects value or an error if the edge
// was not loaded in eager-loading.
func (e UserEdges) SubjectsOrErr() ([]*Subject, error) {
	if e.loadedTypes[1] {
		return e.Subjects, nil
	}
	return nil, &NotLoadedError{edge: "subjects"}
}

// EventsOrErr returns the Events value or an error if the edge
// was not loaded in eager-loading.
func (e UserEdges) EventsOrErr() ([]*Event, error) {
	if e.loadedTypes[2] {
		return e.Events, nil
	}
	return nil, &NotLoadedError{edge: "events"}
}

// MessagesOrErr returns the Messages value or an error if the edge
// was not loaded in eager-loading.
func (e UserEdges) MessagesOrErr() ([]*Message, error) {
	if e.loadedTypes[3] {
		return e.Messages, nil
	}
	return nil, &NotLoadedError{edge: "messages"}
}

// ReportsOrErr returns the Reports value or an error if the edge
// was not loaded in eager-loading.
func (e UserEdges) ReportsOrErr() ([]*Reporting, error) {
	if e.loadedTypes[4] {
		return e.Reports, nil
	}
	return nil, &NotLoadedError{edge: "reports"}
}

// ParticipantsOrErr returns the Participants value or an error if the edge
// was not loaded in eager-loading.
func (e UserEdges) ParticipantsOrErr() ([]*Participant, error) {
	if e.loadedTypes[5] {
		return e.Participants, nil
	}
	return nil, &NotLoadedError{edge: "participants"}
}

// scanValues returns the types for scanning values from sql.Rows.
func (*User) scanValues(columns []string) ([]any, error) {
	values := make([]any, len(columns))
	for i := range columns {
		switch columns[i] {
		case user.FieldActivated:
			values[i] = new(sql.NullBool)
		case user.FieldLng, user.FieldLat:
			values[i] = new(sql.NullFloat64)
		case user.FieldReportNumber:
			values[i] = new(sql.NullInt64)
		case user.FieldID, user.FieldEmail, user.FieldUsername, user.FieldLastname, user.FieldFirstname, user.FieldPassword, user.FieldBio, user.FieldPicture, user.FieldCode, user.FieldRole:
			values[i] = new(sql.NullString)
		case user.FieldBirthDate, user.FieldCreatedAt:
			values[i] = new(sql.NullTime)
		default:
			values[i] = new(sql.UnknownType)
		}
	}
	return values, nil
}

// assignValues assigns the values that were returned from sql.Rows (after scanning)
// to the User fields.
func (u *User) assignValues(columns []string, values []any) error {
	if m, n := len(values), len(columns); m < n {
		return fmt.Errorf("mismatch number of scan values: %d != %d", m, n)
	}
	for i := range columns {
		switch columns[i] {
		case user.FieldID:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field id", values[i])
			} else if value.Valid {
				u.ID = value.String
			}
		case user.FieldEmail:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field email", values[i])
			} else if value.Valid {
				u.Email = value.String
			}
		case user.FieldUsername:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field username", values[i])
			} else if value.Valid {
				u.Username = value.String
			}
		case user.FieldLastname:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field lastname", values[i])
			} else if value.Valid {
				u.Lastname = value.String
			}
		case user.FieldFirstname:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field firstname", values[i])
			} else if value.Valid {
				u.Firstname = value.String
			}
		case user.FieldPassword:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field password", values[i])
			} else if value.Valid {
				u.Password = value.String
			}
		case user.FieldBirthDate:
			if value, ok := values[i].(*sql.NullTime); !ok {
				return fmt.Errorf("unexpected type %T for field birthDate", values[i])
			} else if value.Valid {
				u.BirthDate = value.Time
			}
		case user.FieldBio:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field bio", values[i])
			} else if value.Valid {
				u.Bio = new(string)
				*u.Bio = value.String
			}
		case user.FieldPicture:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field picture", values[i])
			} else if value.Valid {
				u.Picture = new(string)
				*u.Picture = value.String
			}
		case user.FieldActivated:
			if value, ok := values[i].(*sql.NullBool); !ok {
				return fmt.Errorf("unexpected type %T for field activated", values[i])
			} else if value.Valid {
				u.Activated = value.Bool
			}
		case user.FieldReportNumber:
			if value, ok := values[i].(*sql.NullInt64); !ok {
				return fmt.Errorf("unexpected type %T for field reportNumber", values[i])
			} else if value.Valid {
				u.ReportNumber = int(value.Int64)
			}
		case user.FieldLng:
			if value, ok := values[i].(*sql.NullFloat64); !ok {
				return fmt.Errorf("unexpected type %T for field lng", values[i])
			} else if value.Valid {
				u.Lng = new(float64)
				*u.Lng = value.Float64
			}
		case user.FieldLat:
			if value, ok := values[i].(*sql.NullFloat64); !ok {
				return fmt.Errorf("unexpected type %T for field lat", values[i])
			} else if value.Valid {
				u.Lat = new(float64)
				*u.Lat = value.Float64
			}
		case user.FieldCreatedAt:
			if value, ok := values[i].(*sql.NullTime); !ok {
				return fmt.Errorf("unexpected type %T for field created_at", values[i])
			} else if value.Valid {
				u.CreatedAt = value.Time
			}
		case user.FieldCode:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field code", values[i])
			} else if value.Valid {
				u.Code = new(string)
				*u.Code = value.String
			}
		case user.FieldRole:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field role", values[i])
			} else if value.Valid {
				u.Role = user.Role(value.String)
			}
		default:
			u.selectValues.Set(columns[i], values[i])
		}
	}
	return nil
}

// Value returns the ent.Value that was dynamically selected and assigned to the User.
// This includes values selected through modifiers, order, etc.
func (u *User) Value(name string) (ent.Value, error) {
	return u.selectValues.Get(name)
}

// QueryBadges queries the "badges" edge of the User entity.
func (u *User) QueryBadges() *BadgeQuery {
	return NewUserClient(u.config).QueryBadges(u)
}

// QuerySubjects queries the "subjects" edge of the User entity.
func (u *User) QuerySubjects() *SubjectQuery {
	return NewUserClient(u.config).QuerySubjects(u)
}

// QueryEvents queries the "events" edge of the User entity.
func (u *User) QueryEvents() *EventQuery {
	return NewUserClient(u.config).QueryEvents(u)
}

// QueryMessages queries the "messages" edge of the User entity.
func (u *User) QueryMessages() *MessageQuery {
	return NewUserClient(u.config).QueryMessages(u)
}

// QueryReports queries the "reports" edge of the User entity.
func (u *User) QueryReports() *ReportingQuery {
	return NewUserClient(u.config).QueryReports(u)
}

// QueryParticipants queries the "participants" edge of the User entity.
func (u *User) QueryParticipants() *ParticipantQuery {
	return NewUserClient(u.config).QueryParticipants(u)
}

// Update returns a builder for updating this User.
// Note that you need to call User.Unwrap() before calling this method if this User
// was returned from a transaction, and the transaction was committed or rolled back.
func (u *User) Update() *UserUpdateOne {
	return NewUserClient(u.config).UpdateOne(u)
}

// Unwrap unwraps the User entity that was returned from a transaction after it was closed,
// so that all future queries will be executed through the driver which created the transaction.
func (u *User) Unwrap() *User {
	_tx, ok := u.config.driver.(*txDriver)
	if !ok {
		panic("ent: User is not a transactional entity")
	}
	u.config.driver = _tx.drv
	return u
}

// String implements the fmt.Stringer.
func (u *User) String() string {
	var builder strings.Builder
	builder.WriteString("User(")
	builder.WriteString(fmt.Sprintf("id=%v, ", u.ID))
	builder.WriteString("email=")
	builder.WriteString(u.Email)
	builder.WriteString(", ")
	builder.WriteString("username=")
	builder.WriteString(u.Username)
	builder.WriteString(", ")
	builder.WriteString("lastname=")
	builder.WriteString(u.Lastname)
	builder.WriteString(", ")
	builder.WriteString("firstname=")
	builder.WriteString(u.Firstname)
	builder.WriteString(", ")
	builder.WriteString("password=<sensitive>")
	builder.WriteString(", ")
	builder.WriteString("birthDate=")
	builder.WriteString(u.BirthDate.Format(time.ANSIC))
	builder.WriteString(", ")
	if v := u.Bio; v != nil {
		builder.WriteString("bio=")
		builder.WriteString(*v)
	}
	builder.WriteString(", ")
	if v := u.Picture; v != nil {
		builder.WriteString("picture=")
		builder.WriteString(*v)
	}
	builder.WriteString(", ")
	builder.WriteString("activated=")
	builder.WriteString(fmt.Sprintf("%v", u.Activated))
	builder.WriteString(", ")
	builder.WriteString("reportNumber=")
	builder.WriteString(fmt.Sprintf("%v", u.ReportNumber))
	builder.WriteString(", ")
	if v := u.Lng; v != nil {
		builder.WriteString("lng=")
		builder.WriteString(fmt.Sprintf("%v", *v))
	}
	builder.WriteString(", ")
	if v := u.Lat; v != nil {
		builder.WriteString("lat=")
		builder.WriteString(fmt.Sprintf("%v", *v))
	}
	builder.WriteString(", ")
	builder.WriteString("created_at=")
	builder.WriteString(u.CreatedAt.Format(time.ANSIC))
	builder.WriteString(", ")
	if v := u.Code; v != nil {
		builder.WriteString("code=")
		builder.WriteString(*v)
	}
	builder.WriteString(", ")
	builder.WriteString("role=")
	builder.WriteString(fmt.Sprintf("%v", u.Role))
	builder.WriteByte(')')
	return builder.String()
}

// Users is a parsable slice of User.
type Users []*User