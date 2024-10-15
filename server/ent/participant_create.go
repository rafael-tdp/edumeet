// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"edumeet/ent/event"
	"edumeet/ent/participant"
	"edumeet/ent/user"
	"errors"
	"fmt"
	"time"

	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
)

// ParticipantCreate is the builder for creating a Participant entity.
type ParticipantCreate struct {
	config
	mutation *ParticipantMutation
	hooks    []Hook
}

// SetStatus sets the "status" field.
func (pc *ParticipantCreate) SetStatus(s string) *ParticipantCreate {
	pc.mutation.SetStatus(s)
	return pc
}

// SetRequestedAt sets the "requested_at" field.
func (pc *ParticipantCreate) SetRequestedAt(t time.Time) *ParticipantCreate {
	pc.mutation.SetRequestedAt(t)
	return pc
}

// SetNillableRequestedAt sets the "requested_at" field if the given value is not nil.
func (pc *ParticipantCreate) SetNillableRequestedAt(t *time.Time) *ParticipantCreate {
	if t != nil {
		pc.SetRequestedAt(*t)
	}
	return pc
}

// SetJoinedAt sets the "joined_at" field.
func (pc *ParticipantCreate) SetJoinedAt(t time.Time) *ParticipantCreate {
	pc.mutation.SetJoinedAt(t)
	return pc
}

// SetNillableJoinedAt sets the "joined_at" field if the given value is not nil.
func (pc *ParticipantCreate) SetNillableJoinedAt(t *time.Time) *ParticipantCreate {
	if t != nil {
		pc.SetJoinedAt(*t)
	}
	return pc
}

// SetID sets the "id" field.
func (pc *ParticipantCreate) SetID(s string) *ParticipantCreate {
	pc.mutation.SetID(s)
	return pc
}

// SetNillableID sets the "id" field if the given value is not nil.
func (pc *ParticipantCreate) SetNillableID(s *string) *ParticipantCreate {
	if s != nil {
		pc.SetID(*s)
	}
	return pc
}

// SetUserID sets the "user" edge to the User entity by ID.
func (pc *ParticipantCreate) SetUserID(id string) *ParticipantCreate {
	pc.mutation.SetUserID(id)
	return pc
}

// SetNillableUserID sets the "user" edge to the User entity by ID if the given value is not nil.
func (pc *ParticipantCreate) SetNillableUserID(id *string) *ParticipantCreate {
	if id != nil {
		pc = pc.SetUserID(*id)
	}
	return pc
}

// SetUser sets the "user" edge to the User entity.
func (pc *ParticipantCreate) SetUser(u *User) *ParticipantCreate {
	return pc.SetUserID(u.ID)
}

// SetEventID sets the "event" edge to the Event entity by ID.
func (pc *ParticipantCreate) SetEventID(id string) *ParticipantCreate {
	pc.mutation.SetEventID(id)
	return pc
}

// SetNillableEventID sets the "event" edge to the Event entity by ID if the given value is not nil.
func (pc *ParticipantCreate) SetNillableEventID(id *string) *ParticipantCreate {
	if id != nil {
		pc = pc.SetEventID(*id)
	}
	return pc
}

// SetEvent sets the "event" edge to the Event entity.
func (pc *ParticipantCreate) SetEvent(e *Event) *ParticipantCreate {
	return pc.SetEventID(e.ID)
}

// Mutation returns the ParticipantMutation object of the builder.
func (pc *ParticipantCreate) Mutation() *ParticipantMutation {
	return pc.mutation
}

// Save creates the Participant in the database.
func (pc *ParticipantCreate) Save(ctx context.Context) (*Participant, error) {
	pc.defaults()
	return withHooks(ctx, pc.sqlSave, pc.mutation, pc.hooks)
}

// SaveX calls Save and panics if Save returns an error.
func (pc *ParticipantCreate) SaveX(ctx context.Context) *Participant {
	v, err := pc.Save(ctx)
	if err != nil {
		panic(err)
	}
	return v
}

// Exec executes the query.
func (pc *ParticipantCreate) Exec(ctx context.Context) error {
	_, err := pc.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (pc *ParticipantCreate) ExecX(ctx context.Context) {
	if err := pc.Exec(ctx); err != nil {
		panic(err)
	}
}

// defaults sets the default values of the builder before save.
func (pc *ParticipantCreate) defaults() {
	if _, ok := pc.mutation.RequestedAt(); !ok {
		v := participant.DefaultRequestedAt()
		pc.mutation.SetRequestedAt(v)
	}
	if _, ok := pc.mutation.ID(); !ok {
		v := participant.DefaultID()
		pc.mutation.SetID(v)
	}
}

// check runs all checks and user-defined validators on the builder.
func (pc *ParticipantCreate) check() error {
	if _, ok := pc.mutation.Status(); !ok {
		return &ValidationError{Name: "status", err: errors.New(`ent: missing required field "Participant.status"`)}
	}
	if _, ok := pc.mutation.RequestedAt(); !ok {
		return &ValidationError{Name: "requested_at", err: errors.New(`ent: missing required field "Participant.requested_at"`)}
	}
	return nil
}

func (pc *ParticipantCreate) sqlSave(ctx context.Context) (*Participant, error) {
	if err := pc.check(); err != nil {
		return nil, err
	}
	_node, _spec := pc.createSpec()
	if err := sqlgraph.CreateNode(ctx, pc.driver, _spec); err != nil {
		if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return nil, err
	}
	if _spec.ID.Value != nil {
		if id, ok := _spec.ID.Value.(string); ok {
			_node.ID = id
		} else {
			return nil, fmt.Errorf("unexpected Participant.ID type: %T", _spec.ID.Value)
		}
	}
	pc.mutation.id = &_node.ID
	pc.mutation.done = true
	return _node, nil
}

func (pc *ParticipantCreate) createSpec() (*Participant, *sqlgraph.CreateSpec) {
	var (
		_node = &Participant{config: pc.config}
		_spec = sqlgraph.NewCreateSpec(participant.Table, sqlgraph.NewFieldSpec(participant.FieldID, field.TypeString))
	)
	if id, ok := pc.mutation.ID(); ok {
		_node.ID = id
		_spec.ID.Value = id
	}
	if value, ok := pc.mutation.Status(); ok {
		_spec.SetField(participant.FieldStatus, field.TypeString, value)
		_node.Status = value
	}
	if value, ok := pc.mutation.RequestedAt(); ok {
		_spec.SetField(participant.FieldRequestedAt, field.TypeTime, value)
		_node.RequestedAt = value
	}
	if value, ok := pc.mutation.JoinedAt(); ok {
		_spec.SetField(participant.FieldJoinedAt, field.TypeTime, value)
		_node.JoinedAt = value
	}
	if nodes := pc.mutation.UserIDs(); len(nodes) > 0 {
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
		_node.user_participants = &nodes[0]
		_spec.Edges = append(_spec.Edges, edge)
	}
	if nodes := pc.mutation.EventIDs(); len(nodes) > 0 {
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
		_node.event_participants = &nodes[0]
		_spec.Edges = append(_spec.Edges, edge)
	}
	return _node, _spec
}

// ParticipantCreateBulk is the builder for creating many Participant entities in bulk.
type ParticipantCreateBulk struct {
	config
	err      error
	builders []*ParticipantCreate
}

// Save creates the Participant entities in the database.
func (pcb *ParticipantCreateBulk) Save(ctx context.Context) ([]*Participant, error) {
	if pcb.err != nil {
		return nil, pcb.err
	}
	specs := make([]*sqlgraph.CreateSpec, len(pcb.builders))
	nodes := make([]*Participant, len(pcb.builders))
	mutators := make([]Mutator, len(pcb.builders))
	for i := range pcb.builders {
		func(i int, root context.Context) {
			builder := pcb.builders[i]
			builder.defaults()
			var mut Mutator = MutateFunc(func(ctx context.Context, m Mutation) (Value, error) {
				mutation, ok := m.(*ParticipantMutation)
				if !ok {
					return nil, fmt.Errorf("unexpected mutation type %T", m)
				}
				if err := builder.check(); err != nil {
					return nil, err
				}
				builder.mutation = mutation
				var err error
				nodes[i], specs[i] = builder.createSpec()
				if i < len(mutators)-1 {
					_, err = mutators[i+1].Mutate(root, pcb.builders[i+1].mutation)
				} else {
					spec := &sqlgraph.BatchCreateSpec{Nodes: specs}
					// Invoke the actual operation on the latest mutation in the chain.
					if err = sqlgraph.BatchCreate(ctx, pcb.driver, spec); err != nil {
						if sqlgraph.IsConstraintError(err) {
							err = &ConstraintError{msg: err.Error(), wrap: err}
						}
					}
				}
				if err != nil {
					return nil, err
				}
				mutation.id = &nodes[i].ID
				mutation.done = true
				return nodes[i], nil
			})
			for i := len(builder.hooks) - 1; i >= 0; i-- {
				mut = builder.hooks[i](mut)
			}
			mutators[i] = mut
		}(i, ctx)
	}
	if len(mutators) > 0 {
		if _, err := mutators[0].Mutate(ctx, pcb.builders[0].mutation); err != nil {
			return nil, err
		}
	}
	return nodes, nil
}

// SaveX is like Save, but panics if an error occurs.
func (pcb *ParticipantCreateBulk) SaveX(ctx context.Context) []*Participant {
	v, err := pcb.Save(ctx)
	if err != nil {
		panic(err)
	}
	return v
}

// Exec executes the query.
func (pcb *ParticipantCreateBulk) Exec(ctx context.Context) error {
	_, err := pcb.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (pcb *ParticipantCreateBulk) ExecX(ctx context.Context) {
	if err := pcb.Exec(ctx); err != nil {
		panic(err)
	}
}
