// Code generated by ent, DO NOT EDIT.

package ent

import (
	"edumeet/ent/event"
	"edumeet/ent/message"
	"edumeet/ent/user"
	"fmt"
	"strings"
	"time"

	"entgo.io/ent"
	"entgo.io/ent/dialect/sql"
)

// Message is the model entity for the Message schema.
type Message struct {
	config `json:"-"`
	// ID of the ent.
	ID string `json:"id,omitempty"`
	// Content holds the value of the "content" field.
	Content string `json:"content,omitempty"`
	// SentAt holds the value of the "sent_at" field.
	SentAt time.Time `json:"sent_at,omitempty"`
	// Edges holds the relations/edges for other nodes in the graph.
	// The values are being populated by the MessageQuery when eager-loading is set.
	Edges          MessageEdges `json:"edges"`
	event_messages *string
	user_messages  *string
	selectValues   sql.SelectValues
}

// MessageEdges holds the relations/edges for other nodes in the graph.
type MessageEdges struct {
	// User holds the value of the user edge.
	User *User `json:"user,omitempty"`
	// Event holds the value of the event edge.
	Event *Event `json:"event,omitempty"`
	// Documents holds the value of the documents edge.
	Documents []*Document `json:"documents,omitempty"`
	// loadedTypes holds the information for reporting if a
	// type was loaded (or requested) in eager-loading or not.
	loadedTypes [3]bool
}

// UserOrErr returns the User value or an error if the edge
// was not loaded in eager-loading, or loaded but was not found.
func (e MessageEdges) UserOrErr() (*User, error) {
	if e.User != nil {
		return e.User, nil
	} else if e.loadedTypes[0] {
		return nil, &NotFoundError{label: user.Label}
	}
	return nil, &NotLoadedError{edge: "user"}
}

// EventOrErr returns the Event value or an error if the edge
// was not loaded in eager-loading, or loaded but was not found.
func (e MessageEdges) EventOrErr() (*Event, error) {
	if e.Event != nil {
		return e.Event, nil
	} else if e.loadedTypes[1] {
		return nil, &NotFoundError{label: event.Label}
	}
	return nil, &NotLoadedError{edge: "event"}
}

// DocumentsOrErr returns the Documents value or an error if the edge
// was not loaded in eager-loading.
func (e MessageEdges) DocumentsOrErr() ([]*Document, error) {
	if e.loadedTypes[2] {
		return e.Documents, nil
	}
	return nil, &NotLoadedError{edge: "documents"}
}

// scanValues returns the types for scanning values from sql.Rows.
func (*Message) scanValues(columns []string) ([]any, error) {
	values := make([]any, len(columns))
	for i := range columns {
		switch columns[i] {
		case message.FieldID, message.FieldContent:
			values[i] = new(sql.NullString)
		case message.FieldSentAt:
			values[i] = new(sql.NullTime)
		case message.ForeignKeys[0]: // event_messages
			values[i] = new(sql.NullString)
		case message.ForeignKeys[1]: // user_messages
			values[i] = new(sql.NullString)
		default:
			values[i] = new(sql.UnknownType)
		}
	}
	return values, nil
}

// assignValues assigns the values that were returned from sql.Rows (after scanning)
// to the Message fields.
func (m *Message) assignValues(columns []string, values []any) error {
	if m, n := len(values), len(columns); m < n {
		return fmt.Errorf("mismatch number of scan values: %d != %d", m, n)
	}
	for i := range columns {
		switch columns[i] {
		case message.FieldID:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field id", values[i])
			} else if value.Valid {
				m.ID = value.String
			}
		case message.FieldContent:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field content", values[i])
			} else if value.Valid {
				m.Content = value.String
			}
		case message.FieldSentAt:
			if value, ok := values[i].(*sql.NullTime); !ok {
				return fmt.Errorf("unexpected type %T for field sent_at", values[i])
			} else if value.Valid {
				m.SentAt = value.Time
			}
		case message.ForeignKeys[0]:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field event_messages", values[i])
			} else if value.Valid {
				m.event_messages = new(string)
				*m.event_messages = value.String
			}
		case message.ForeignKeys[1]:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field user_messages", values[i])
			} else if value.Valid {
				m.user_messages = new(string)
				*m.user_messages = value.String
			}
		default:
			m.selectValues.Set(columns[i], values[i])
		}
	}
	return nil
}

// Value returns the ent.Value that was dynamically selected and assigned to the Message.
// This includes values selected through modifiers, order, etc.
func (m *Message) Value(name string) (ent.Value, error) {
	return m.selectValues.Get(name)
}

// QueryUser queries the "user" edge of the Message entity.
func (m *Message) QueryUser() *UserQuery {
	return NewMessageClient(m.config).QueryUser(m)
}

// QueryEvent queries the "event" edge of the Message entity.
func (m *Message) QueryEvent() *EventQuery {
	return NewMessageClient(m.config).QueryEvent(m)
}

// QueryDocuments queries the "documents" edge of the Message entity.
func (m *Message) QueryDocuments() *DocumentQuery {
	return NewMessageClient(m.config).QueryDocuments(m)
}

// Update returns a builder for updating this Message.
// Note that you need to call Message.Unwrap() before calling this method if this Message
// was returned from a transaction, and the transaction was committed or rolled back.
func (m *Message) Update() *MessageUpdateOne {
	return NewMessageClient(m.config).UpdateOne(m)
}

// Unwrap unwraps the Message entity that was returned from a transaction after it was closed,
// so that all future queries will be executed through the driver which created the transaction.
func (m *Message) Unwrap() *Message {
	_tx, ok := m.config.driver.(*txDriver)
	if !ok {
		panic("ent: Message is not a transactional entity")
	}
	m.config.driver = _tx.drv
	return m
}

// String implements the fmt.Stringer.
func (m *Message) String() string {
	var builder strings.Builder
	builder.WriteString("Message(")
	builder.WriteString(fmt.Sprintf("id=%v, ", m.ID))
	builder.WriteString("content=")
	builder.WriteString(m.Content)
	builder.WriteString(", ")
	builder.WriteString("sent_at=")
	builder.WriteString(m.SentAt.Format(time.ANSIC))
	builder.WriteByte(')')
	return builder.String()
}

// Messages is a parsable slice of Message.
type Messages []*Message