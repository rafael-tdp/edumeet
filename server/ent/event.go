// Code generated by ent, DO NOT EDIT.

package ent

import (
	"edumeet/ent/event"
	"edumeet/ent/message"
	"edumeet/ent/physicalevent"
	"edumeet/ent/remoteevent"
	"edumeet/ent/user"
	"fmt"
	"strings"
	"time"

	"entgo.io/ent"
	"entgo.io/ent/dialect/sql"
)

// Event is the model entity for the Event schema.
type Event struct {
	config `json:"-"`
	// ID of the ent.
	ID string `json:"id,omitempty"`
	// NbMaxUser holds the value of the "nbMaxUser" field.
	NbMaxUser int `json:"nbMaxUser,omitempty"`
	// StartDate holds the value of the "start_date" field.
	StartDate time.Time `json:"start_date,omitempty"`
	// EndDate holds the value of the "end_date" field.
	EndDate time.Time `json:"end_date,omitempty"`
	// IsPrivate holds the value of the "isPrivate" field.
	IsPrivate bool `json:"isPrivate,omitempty"`
	// Title holds the value of the "title" field.
	Title string `json:"title,omitempty"`
	// Description holds the value of the "description" field.
	Description string `json:"description,omitempty"`
	// InvitationLink holds the value of the "invitationLink" field.
	InvitationLink string `json:"invitationLink,omitempty"`
	// Edges holds the relations/edges for other nodes in the graph.
	// The values are being populated by the EventQuery when eager-loading is set.
	Edges        EventEdges `json:"edges"`
	user_events  *string
	selectValues sql.SelectValues
}

// EventEdges holds the relations/edges for other nodes in the graph.
type EventEdges struct {
	// User holds the value of the user edge.
	User *User `json:"user,omitempty"`
	// Messages holds the value of the messages edge.
	Messages *Message `json:"messages,omitempty"`
	// EventDocuments holds the value of the event_documents edge.
	EventDocuments []*EventDocument `json:"event_documents,omitempty"`
	// Subjects holds the value of the subjects edge.
	Subjects []*Subject `json:"subjects,omitempty"`
	// Participants holds the value of the participants edge.
	Participants []*Participant `json:"participants,omitempty"`
	// RemoteEvent holds the value of the remote_event edge.
	RemoteEvent *RemoteEvent `json:"remote_event,omitempty"`
	// PhysicalEvent holds the value of the physical_event edge.
	PhysicalEvent *PhysicalEvent `json:"physical_event,omitempty"`
	// loadedTypes holds the information for reporting if a
	// type was loaded (or requested) in eager-loading or not.
	loadedTypes [7]bool
}

// UserOrErr returns the User value or an error if the edge
// was not loaded in eager-loading, or loaded but was not found.
func (e EventEdges) UserOrErr() (*User, error) {
	if e.User != nil {
		return e.User, nil
	} else if e.loadedTypes[0] {
		return nil, &NotFoundError{label: user.Label}
	}
	return nil, &NotLoadedError{edge: "user"}
}

// MessagesOrErr returns the Messages value or an error if the edge
// was not loaded in eager-loading, or loaded but was not found.
func (e EventEdges) MessagesOrErr() (*Message, error) {
	if e.Messages != nil {
		return e.Messages, nil
	} else if e.loadedTypes[1] {
		return nil, &NotFoundError{label: message.Label}
	}
	return nil, &NotLoadedError{edge: "messages"}
}

// EventDocumentsOrErr returns the EventDocuments value or an error if the edge
// was not loaded in eager-loading.
func (e EventEdges) EventDocumentsOrErr() ([]*EventDocument, error) {
	if e.loadedTypes[2] {
		return e.EventDocuments, nil
	}
	return nil, &NotLoadedError{edge: "event_documents"}
}

// SubjectsOrErr returns the Subjects value or an error if the edge
// was not loaded in eager-loading.
func (e EventEdges) SubjectsOrErr() ([]*Subject, error) {
	if e.loadedTypes[3] {
		return e.Subjects, nil
	}
	return nil, &NotLoadedError{edge: "subjects"}
}

// ParticipantsOrErr returns the Participants value or an error if the edge
// was not loaded in eager-loading.
func (e EventEdges) ParticipantsOrErr() ([]*Participant, error) {
	if e.loadedTypes[4] {
		return e.Participants, nil
	}
	return nil, &NotLoadedError{edge: "participants"}
}

// RemoteEventOrErr returns the RemoteEvent value or an error if the edge
// was not loaded in eager-loading, or loaded but was not found.
func (e EventEdges) RemoteEventOrErr() (*RemoteEvent, error) {
	if e.RemoteEvent != nil {
		return e.RemoteEvent, nil
	} else if e.loadedTypes[5] {
		return nil, &NotFoundError{label: remoteevent.Label}
	}
	return nil, &NotLoadedError{edge: "remote_event"}
}

// PhysicalEventOrErr returns the PhysicalEvent value or an error if the edge
// was not loaded in eager-loading, or loaded but was not found.
func (e EventEdges) PhysicalEventOrErr() (*PhysicalEvent, error) {
	if e.PhysicalEvent != nil {
		return e.PhysicalEvent, nil
	} else if e.loadedTypes[6] {
		return nil, &NotFoundError{label: physicalevent.Label}
	}
	return nil, &NotLoadedError{edge: "physical_event"}
}

// scanValues returns the types for scanning values from sql.Rows.
func (*Event) scanValues(columns []string) ([]any, error) {
	values := make([]any, len(columns))
	for i := range columns {
		switch columns[i] {
		case event.FieldIsPrivate:
			values[i] = new(sql.NullBool)
		case event.FieldNbMaxUser:
			values[i] = new(sql.NullInt64)
		case event.FieldID, event.FieldTitle, event.FieldDescription, event.FieldInvitationLink:
			values[i] = new(sql.NullString)
		case event.FieldStartDate, event.FieldEndDate:
			values[i] = new(sql.NullTime)
		case event.ForeignKeys[0]: // user_events
			values[i] = new(sql.NullString)
		default:
			values[i] = new(sql.UnknownType)
		}
	}
	return values, nil
}

// assignValues assigns the values that were returned from sql.Rows (after scanning)
// to the Event fields.
func (e *Event) assignValues(columns []string, values []any) error {
	if m, n := len(values), len(columns); m < n {
		return fmt.Errorf("mismatch number of scan values: %d != %d", m, n)
	}
	for i := range columns {
		switch columns[i] {
		case event.FieldID:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field id", values[i])
			} else if value.Valid {
				e.ID = value.String
			}
		case event.FieldNbMaxUser:
			if value, ok := values[i].(*sql.NullInt64); !ok {
				return fmt.Errorf("unexpected type %T for field nbMaxUser", values[i])
			} else if value.Valid {
				e.NbMaxUser = int(value.Int64)
			}
		case event.FieldStartDate:
			if value, ok := values[i].(*sql.NullTime); !ok {
				return fmt.Errorf("unexpected type %T for field start_date", values[i])
			} else if value.Valid {
				e.StartDate = value.Time
			}
		case event.FieldEndDate:
			if value, ok := values[i].(*sql.NullTime); !ok {
				return fmt.Errorf("unexpected type %T for field end_date", values[i])
			} else if value.Valid {
				e.EndDate = value.Time
			}
		case event.FieldIsPrivate:
			if value, ok := values[i].(*sql.NullBool); !ok {
				return fmt.Errorf("unexpected type %T for field isPrivate", values[i])
			} else if value.Valid {
				e.IsPrivate = value.Bool
			}
		case event.FieldTitle:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field title", values[i])
			} else if value.Valid {
				e.Title = value.String
			}
		case event.FieldDescription:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field description", values[i])
			} else if value.Valid {
				e.Description = value.String
			}
		case event.FieldInvitationLink:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field invitationLink", values[i])
			} else if value.Valid {
				e.InvitationLink = value.String
			}
		case event.ForeignKeys[0]:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field user_events", values[i])
			} else if value.Valid {
				e.user_events = new(string)
				*e.user_events = value.String
			}
		default:
			e.selectValues.Set(columns[i], values[i])
		}
	}
	return nil
}

// Value returns the ent.Value that was dynamically selected and assigned to the Event.
// This includes values selected through modifiers, order, etc.
func (e *Event) Value(name string) (ent.Value, error) {
	return e.selectValues.Get(name)
}

// QueryUser queries the "user" edge of the Event entity.
func (e *Event) QueryUser() *UserQuery {
	return NewEventClient(e.config).QueryUser(e)
}

// QueryMessages queries the "messages" edge of the Event entity.
func (e *Event) QueryMessages() *MessageQuery {
	return NewEventClient(e.config).QueryMessages(e)
}

// QueryEventDocuments queries the "event_documents" edge of the Event entity.
func (e *Event) QueryEventDocuments() *EventDocumentQuery {
	return NewEventClient(e.config).QueryEventDocuments(e)
}

// QuerySubjects queries the "subjects" edge of the Event entity.
func (e *Event) QuerySubjects() *SubjectQuery {
	return NewEventClient(e.config).QuerySubjects(e)
}

// QueryParticipants queries the "participants" edge of the Event entity.
func (e *Event) QueryParticipants() *ParticipantQuery {
	return NewEventClient(e.config).QueryParticipants(e)
}

// QueryRemoteEvent queries the "remote_event" edge of the Event entity.
func (e *Event) QueryRemoteEvent() *RemoteEventQuery {
	return NewEventClient(e.config).QueryRemoteEvent(e)
}

// QueryPhysicalEvent queries the "physical_event" edge of the Event entity.
func (e *Event) QueryPhysicalEvent() *PhysicalEventQuery {
	return NewEventClient(e.config).QueryPhysicalEvent(e)
}

// Update returns a builder for updating this Event.
// Note that you need to call Event.Unwrap() before calling this method if this Event
// was returned from a transaction, and the transaction was committed or rolled back.
func (e *Event) Update() *EventUpdateOne {
	return NewEventClient(e.config).UpdateOne(e)
}

// Unwrap unwraps the Event entity that was returned from a transaction after it was closed,
// so that all future queries will be executed through the driver which created the transaction.
func (e *Event) Unwrap() *Event {
	_tx, ok := e.config.driver.(*txDriver)
	if !ok {
		panic("ent: Event is not a transactional entity")
	}
	e.config.driver = _tx.drv
	return e
}

// String implements the fmt.Stringer.
func (e *Event) String() string {
	var builder strings.Builder
	builder.WriteString("Event(")
	builder.WriteString(fmt.Sprintf("id=%v, ", e.ID))
	builder.WriteString("nbMaxUser=")
	builder.WriteString(fmt.Sprintf("%v", e.NbMaxUser))
	builder.WriteString(", ")
	builder.WriteString("start_date=")
	builder.WriteString(e.StartDate.Format(time.ANSIC))
	builder.WriteString(", ")
	builder.WriteString("end_date=")
	builder.WriteString(e.EndDate.Format(time.ANSIC))
	builder.WriteString(", ")
	builder.WriteString("isPrivate=")
	builder.WriteString(fmt.Sprintf("%v", e.IsPrivate))
	builder.WriteString(", ")
	builder.WriteString("title=")
	builder.WriteString(e.Title)
	builder.WriteString(", ")
	builder.WriteString("description=")
	builder.WriteString(e.Description)
	builder.WriteString(", ")
	builder.WriteString("invitationLink=")
	builder.WriteString(e.InvitationLink)
	builder.WriteByte(')')
	return builder.String()
}

// Events is a parsable slice of Event.
type Events []*Event
