// Code generated by ent, DO NOT EDIT.

package ent

import (
	"edumeet/ent/reporting"
	"edumeet/ent/user"
	"fmt"
	"strings"

	"entgo.io/ent"
	"entgo.io/ent/dialect/sql"
)

// Reporting is the model entity for the Reporting schema.
type Reporting struct {
	config `json:"-"`
	// ID of the ent.
	ID string `json:"id,omitempty"`
	// Reason holds the value of the "reason" field.
	Reason string `json:"reason,omitempty"`
	// Type holds the value of the "type" field.
	Type string `json:"type,omitempty"`
	// EntityID holds the value of the "entity_id" field.
	EntityID string `json:"entity_id,omitempty"`
	// Edges holds the relations/edges for other nodes in the graph.
	// The values are being populated by the ReportingQuery when eager-loading is set.
	Edges        ReportingEdges `json:"edges"`
	user_reports *string
	selectValues sql.SelectValues
}

// ReportingEdges holds the relations/edges for other nodes in the graph.
type ReportingEdges struct {
	// User holds the value of the user edge.
	User *User `json:"user,omitempty"`
	// loadedTypes holds the information for reporting if a
	// type was loaded (or requested) in eager-loading or not.
	loadedTypes [1]bool
}

// UserOrErr returns the User value or an error if the edge
// was not loaded in eager-loading, or loaded but was not found.
func (e ReportingEdges) UserOrErr() (*User, error) {
	if e.User != nil {
		return e.User, nil
	} else if e.loadedTypes[0] {
		return nil, &NotFoundError{label: user.Label}
	}
	return nil, &NotLoadedError{edge: "user"}
}

// scanValues returns the types for scanning values from sql.Rows.
func (*Reporting) scanValues(columns []string) ([]any, error) {
	values := make([]any, len(columns))
	for i := range columns {
		switch columns[i] {
		case reporting.FieldID, reporting.FieldReason, reporting.FieldType, reporting.FieldEntityID:
			values[i] = new(sql.NullString)
		case reporting.ForeignKeys[0]: // user_reports
			values[i] = new(sql.NullString)
		default:
			values[i] = new(sql.UnknownType)
		}
	}
	return values, nil
}

// assignValues assigns the values that were returned from sql.Rows (after scanning)
// to the Reporting fields.
func (r *Reporting) assignValues(columns []string, values []any) error {
	if m, n := len(values), len(columns); m < n {
		return fmt.Errorf("mismatch number of scan values: %d != %d", m, n)
	}
	for i := range columns {
		switch columns[i] {
		case reporting.FieldID:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field id", values[i])
			} else if value.Valid {
				r.ID = value.String
			}
		case reporting.FieldReason:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field reason", values[i])
			} else if value.Valid {
				r.Reason = value.String
			}
		case reporting.FieldType:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field type", values[i])
			} else if value.Valid {
				r.Type = value.String
			}
		case reporting.FieldEntityID:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field entity_id", values[i])
			} else if value.Valid {
				r.EntityID = value.String
			}
		case reporting.ForeignKeys[0]:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field user_reports", values[i])
			} else if value.Valid {
				r.user_reports = new(string)
				*r.user_reports = value.String
			}
		default:
			r.selectValues.Set(columns[i], values[i])
		}
	}
	return nil
}

// Value returns the ent.Value that was dynamically selected and assigned to the Reporting.
// This includes values selected through modifiers, order, etc.
func (r *Reporting) Value(name string) (ent.Value, error) {
	return r.selectValues.Get(name)
}

// QueryUser queries the "user" edge of the Reporting entity.
func (r *Reporting) QueryUser() *UserQuery {
	return NewReportingClient(r.config).QueryUser(r)
}

// Update returns a builder for updating this Reporting.
// Note that you need to call Reporting.Unwrap() before calling this method if this Reporting
// was returned from a transaction, and the transaction was committed or rolled back.
func (r *Reporting) Update() *ReportingUpdateOne {
	return NewReportingClient(r.config).UpdateOne(r)
}

// Unwrap unwraps the Reporting entity that was returned from a transaction after it was closed,
// so that all future queries will be executed through the driver which created the transaction.
func (r *Reporting) Unwrap() *Reporting {
	_tx, ok := r.config.driver.(*txDriver)
	if !ok {
		panic("ent: Reporting is not a transactional entity")
	}
	r.config.driver = _tx.drv
	return r
}

// String implements the fmt.Stringer.
func (r *Reporting) String() string {
	var builder strings.Builder
	builder.WriteString("Reporting(")
	builder.WriteString(fmt.Sprintf("id=%v, ", r.ID))
	builder.WriteString("reason=")
	builder.WriteString(r.Reason)
	builder.WriteString(", ")
	builder.WriteString("type=")
	builder.WriteString(r.Type)
	builder.WriteString(", ")
	builder.WriteString("entity_id=")
	builder.WriteString(r.EntityID)
	builder.WriteByte(')')
	return builder.String()
}

// Reportings is a parsable slice of Reporting.
type Reportings []*Reporting
