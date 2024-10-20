// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"edumeet/ent/event"
	"edumeet/ent/participant"
	"edumeet/ent/predicate"
	"edumeet/ent/user"
	"errors"
	"fmt"
	"time"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
)

// ParticipantUpdate is the builder for updating Participant entities.
type ParticipantUpdate struct {
	config
	hooks    []Hook
	mutation *ParticipantMutation
}

// Where appends a list predicates to the ParticipantUpdate builder.
func (pu *ParticipantUpdate) Where(ps ...predicate.Participant) *ParticipantUpdate {
	pu.mutation.Where(ps...)
	return pu
}

// SetStatus sets the "status" field.
func (pu *ParticipantUpdate) SetStatus(s string) *ParticipantUpdate {
	pu.mutation.SetStatus(s)
	return pu
}

// SetNillableStatus sets the "status" field if the given value is not nil.
func (pu *ParticipantUpdate) SetNillableStatus(s *string) *ParticipantUpdate {
	if s != nil {
		pu.SetStatus(*s)
	}
	return pu
}

// SetRequestedAt sets the "requested_at" field.
func (pu *ParticipantUpdate) SetRequestedAt(t time.Time) *ParticipantUpdate {
	pu.mutation.SetRequestedAt(t)
	return pu
}

// SetNillableRequestedAt sets the "requested_at" field if the given value is not nil.
func (pu *ParticipantUpdate) SetNillableRequestedAt(t *time.Time) *ParticipantUpdate {
	if t != nil {
		pu.SetRequestedAt(*t)
	}
	return pu
}

// SetJoinedAt sets the "joined_at" field.
func (pu *ParticipantUpdate) SetJoinedAt(t time.Time) *ParticipantUpdate {
	pu.mutation.SetJoinedAt(t)
	return pu
}

// SetNillableJoinedAt sets the "joined_at" field if the given value is not nil.
func (pu *ParticipantUpdate) SetNillableJoinedAt(t *time.Time) *ParticipantUpdate {
	if t != nil {
		pu.SetJoinedAt(*t)
	}
	return pu
}

// ClearJoinedAt clears the value of the "joined_at" field.
func (pu *ParticipantUpdate) ClearJoinedAt() *ParticipantUpdate {
	pu.mutation.ClearJoinedAt()
	return pu
}

// SetUserID sets the "user" edge to the User entity by ID.
func (pu *ParticipantUpdate) SetUserID(id string) *ParticipantUpdate {
	pu.mutation.SetUserID(id)
	return pu
}

// SetNillableUserID sets the "user" edge to the User entity by ID if the given value is not nil.
func (pu *ParticipantUpdate) SetNillableUserID(id *string) *ParticipantUpdate {
	if id != nil {
		pu = pu.SetUserID(*id)
	}
	return pu
}

// SetUser sets the "user" edge to the User entity.
func (pu *ParticipantUpdate) SetUser(u *User) *ParticipantUpdate {
	return pu.SetUserID(u.ID)
}

// SetEventID sets the "event" edge to the Event entity by ID.
func (pu *ParticipantUpdate) SetEventID(id string) *ParticipantUpdate {
	pu.mutation.SetEventID(id)
	return pu
}

// SetNillableEventID sets the "event" edge to the Event entity by ID if the given value is not nil.
func (pu *ParticipantUpdate) SetNillableEventID(id *string) *ParticipantUpdate {
	if id != nil {
		pu = pu.SetEventID(*id)
	}
	return pu
}

// SetEvent sets the "event" edge to the Event entity.
func (pu *ParticipantUpdate) SetEvent(e *Event) *ParticipantUpdate {
	return pu.SetEventID(e.ID)
}

// Mutation returns the ParticipantMutation object of the builder.
func (pu *ParticipantUpdate) Mutation() *ParticipantMutation {
	return pu.mutation
}

// ClearUser clears the "user" edge to the User entity.
func (pu *ParticipantUpdate) ClearUser() *ParticipantUpdate {
	pu.mutation.ClearUser()
	return pu
}

// ClearEvent clears the "event" edge to the Event entity.
func (pu *ParticipantUpdate) ClearEvent() *ParticipantUpdate {
	pu.mutation.ClearEvent()
	return pu
}

// Save executes the query and returns the number of nodes affected by the update operation.
func (pu *ParticipantUpdate) Save(ctx context.Context) (int, error) {
	return withHooks(ctx, pu.sqlSave, pu.mutation, pu.hooks)
}

// SaveX is like Save, but panics if an error occurs.
func (pu *ParticipantUpdate) SaveX(ctx context.Context) int {
	affected, err := pu.Save(ctx)
	if err != nil {
		panic(err)
	}
	return affected
}

// Exec executes the query.
func (pu *ParticipantUpdate) Exec(ctx context.Context) error {
	_, err := pu.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (pu *ParticipantUpdate) ExecX(ctx context.Context) {
	if err := pu.Exec(ctx); err != nil {
		panic(err)
	}
}

func (pu *ParticipantUpdate) sqlSave(ctx context.Context) (n int, err error) {
	_spec := sqlgraph.NewUpdateSpec(participant.Table, participant.Columns, sqlgraph.NewFieldSpec(participant.FieldID, field.TypeString))
	if ps := pu.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	if value, ok := pu.mutation.Status(); ok {
		_spec.SetField(participant.FieldStatus, field.TypeString, value)
	}
	if value, ok := pu.mutation.RequestedAt(); ok {
		_spec.SetField(participant.FieldRequestedAt, field.TypeTime, value)
	}
	if value, ok := pu.mutation.JoinedAt(); ok {
		_spec.SetField(participant.FieldJoinedAt, field.TypeTime, value)
	}
	if pu.mutation.JoinedAtCleared() {
		_spec.ClearField(participant.FieldJoinedAt, field.TypeTime)
	}
	if pu.mutation.UserCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: true,
			Table:   participant.UserTable,
			Columns: []string{participant.UserColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeString),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := pu.mutation.UserIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: true,
			Table:   participant.UserTable,
			Columns: []string{participant.UserColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeString),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if pu.mutation.EventCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: true,
			Table:   participant.EventTable,
			Columns: []string{participant.EventColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(event.FieldID, field.TypeString),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := pu.mutation.EventIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: true,
			Table:   participant.EventTable,
			Columns: []string{participant.EventColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(event.FieldID, field.TypeString),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if n, err = sqlgraph.UpdateNodes(ctx, pu.driver, _spec); err != nil {
		if _, ok := err.(*sqlgraph.NotFoundError); ok {
			err = &NotFoundError{participant.Label}
		} else if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return 0, err
	}
	pu.mutation.done = true
	return n, nil
}

// ParticipantUpdateOne is the builder for updating a single Participant entity.
type ParticipantUpdateOne struct {
	config
	fields   []string
	hooks    []Hook
	mutation *ParticipantMutation
}

// SetStatus sets the "status" field.
func (puo *ParticipantUpdateOne) SetStatus(s string) *ParticipantUpdateOne {
	puo.mutation.SetStatus(s)
	return puo
}

// SetNillableStatus sets the "status" field if the given value is not nil.
func (puo *ParticipantUpdateOne) SetNillableStatus(s *string) *ParticipantUpdateOne {
	if s != nil {
		puo.SetStatus(*s)
	}
	return puo
}

// SetRequestedAt sets the "requested_at" field.
func (puo *ParticipantUpdateOne) SetRequestedAt(t time.Time) *ParticipantUpdateOne {
	puo.mutation.SetRequestedAt(t)
	return puo
}

// SetNillableRequestedAt sets the "requested_at" field if the given value is not nil.
func (puo *ParticipantUpdateOne) SetNillableRequestedAt(t *time.Time) *ParticipantUpdateOne {
	if t != nil {
		puo.SetRequestedAt(*t)
	}
	return puo
}

// SetJoinedAt sets the "joined_at" field.
func (puo *ParticipantUpdateOne) SetJoinedAt(t time.Time) *ParticipantUpdateOne {
	puo.mutation.SetJoinedAt(t)
	return puo
}

// SetNillableJoinedAt sets the "joined_at" field if the given value is not nil.
func (puo *ParticipantUpdateOne) SetNillableJoinedAt(t *time.Time) *ParticipantUpdateOne {
	if t != nil {
		puo.SetJoinedAt(*t)
	}
	return puo
}

// ClearJoinedAt clears the value of the "joined_at" field.
func (puo *ParticipantUpdateOne) ClearJoinedAt() *ParticipantUpdateOne {
	puo.mutation.ClearJoinedAt()
	return puo
}

// SetUserID sets the "user" edge to the User entity by ID.
func (puo *ParticipantUpdateOne) SetUserID(id string) *ParticipantUpdateOne {
	puo.mutation.SetUserID(id)
	return puo
}

// SetNillableUserID sets the "user" edge to the User entity by ID if the given value is not nil.
func (puo *ParticipantUpdateOne) SetNillableUserID(id *string) *ParticipantUpdateOne {
	if id != nil {
		puo = puo.SetUserID(*id)
	}
	return puo
}

// SetUser sets the "user" edge to the User entity.
func (puo *ParticipantUpdateOne) SetUser(u *User) *ParticipantUpdateOne {
	return puo.SetUserID(u.ID)
}

// SetEventID sets the "event" edge to the Event entity by ID.
func (puo *ParticipantUpdateOne) SetEventID(id string) *ParticipantUpdateOne {
	puo.mutation.SetEventID(id)
	return puo
}

// SetNillableEventID sets the "event" edge to the Event entity by ID if the given value is not nil.
func (puo *ParticipantUpdateOne) SetNillableEventID(id *string) *ParticipantUpdateOne {
	if id != nil {
		puo = puo.SetEventID(*id)
	}
	return puo
}

// SetEvent sets the "event" edge to the Event entity.
func (puo *ParticipantUpdateOne) SetEvent(e *Event) *ParticipantUpdateOne {
	return puo.SetEventID(e.ID)
}

// Mutation returns the ParticipantMutation object of the builder.
func (puo *ParticipantUpdateOne) Mutation() *ParticipantMutation {
	return puo.mutation
}

// ClearUser clears the "user" edge to the User entity.
func (puo *ParticipantUpdateOne) ClearUser() *ParticipantUpdateOne {
	puo.mutation.ClearUser()
	return puo
}

// ClearEvent clears the "event" edge to the Event entity.
func (puo *ParticipantUpdateOne) ClearEvent() *ParticipantUpdateOne {
	puo.mutation.ClearEvent()
	return puo
}

// Where appends a list predicates to the ParticipantUpdate builder.
func (puo *ParticipantUpdateOne) Where(ps ...predicate.Participant) *ParticipantUpdateOne {
	puo.mutation.Where(ps...)
	return puo
}

// Select allows selecting one or more fields (columns) of the returned entity.
// The default is selecting all fields defined in the entity schema.
func (puo *ParticipantUpdateOne) Select(field string, fields ...string) *ParticipantUpdateOne {
	puo.fields = append([]string{field}, fields...)
	return puo
}

// Save executes the query and returns the updated Participant entity.
func (puo *ParticipantUpdateOne) Save(ctx context.Context) (*Participant, error) {
	return withHooks(ctx, puo.sqlSave, puo.mutation, puo.hooks)
}

// SaveX is like Save, but panics if an error occurs.
func (puo *ParticipantUpdateOne) SaveX(ctx context.Context) *Participant {
	node, err := puo.Save(ctx)
	if err != nil {
		panic(err)
	}
	return node
}

// Exec executes the query on the entity.
func (puo *ParticipantUpdateOne) Exec(ctx context.Context) error {
	_, err := puo.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (puo *ParticipantUpdateOne) ExecX(ctx context.Context) {
	if err := puo.Exec(ctx); err != nil {
		panic(err)
	}
}

func (puo *ParticipantUpdateOne) sqlSave(ctx context.Context) (_node *Participant, err error) {
	_spec := sqlgraph.NewUpdateSpec(participant.Table, participant.Columns, sqlgraph.NewFieldSpec(participant.FieldID, field.TypeString))
	id, ok := puo.mutation.ID()
	if !ok {
		return nil, &ValidationError{Name: "id", err: errors.New(`ent: missing "Participant.id" for update`)}
	}
	_spec.Node.ID.Value = id
	if fields := puo.fields; len(fields) > 0 {
		_spec.Node.Columns = make([]string, 0, len(fields))
		_spec.Node.Columns = append(_spec.Node.Columns, participant.FieldID)
		for _, f := range fields {
			if !participant.ValidColumn(f) {
				return nil, &ValidationError{Name: f, err: fmt.Errorf("ent: invalid field %q for query", f)}
			}
			if f != participant.FieldID {
				_spec.Node.Columns = append(_spec.Node.Columns, f)
			}
		}
	}
	if ps := puo.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	if value, ok := puo.mutation.Status(); ok {
		_spec.SetField(participant.FieldStatus, field.TypeString, value)
	}
	if value, ok := puo.mutation.RequestedAt(); ok {
		_spec.SetField(participant.FieldRequestedAt, field.TypeTime, value)
	}
	if value, ok := puo.mutation.JoinedAt(); ok {
		_spec.SetField(participant.FieldJoinedAt, field.TypeTime, value)
	}
	if puo.mutation.JoinedAtCleared() {
		_spec.ClearField(participant.FieldJoinedAt, field.TypeTime)
	}
	if puo.mutation.UserCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: true,
			Table:   participant.UserTable,
			Columns: []string{participant.UserColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeString),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := puo.mutation.UserIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: true,
			Table:   participant.UserTable,
			Columns: []string{participant.UserColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeString),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if puo.mutation.EventCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: true,
			Table:   participant.EventTable,
			Columns: []string{participant.EventColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(event.FieldID, field.TypeString),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := puo.mutation.EventIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: true,
			Table:   participant.EventTable,
			Columns: []string{participant.EventColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(event.FieldID, field.TypeString),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	_node = &Participant{config: puo.config}
	_spec.Assign = _node.assignValues
	_spec.ScanValues = _node.scanValues
	if err = sqlgraph.UpdateNode(ctx, puo.driver, _spec); err != nil {
		if _, ok := err.(*sqlgraph.NotFoundError); ok {
			err = &NotFoundError{participant.Label}
		} else if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return nil, err
	}
	puo.mutation.done = true
	return _node, nil
}
