// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"edumeet/ent/event"
	"edumeet/ent/physicalevent"
	"errors"
	"fmt"

	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
)

// PhysicalEventCreate is the builder for creating a PhysicalEvent entity.
type PhysicalEventCreate struct {
	config
	mutation *PhysicalEventMutation
	hooks    []Hook
}

// SetLng sets the "lng" field.
func (pec *PhysicalEventCreate) SetLng(f float64) *PhysicalEventCreate {
	pec.mutation.SetLng(f)
	return pec
}

// SetLat sets the "lat" field.
func (pec *PhysicalEventCreate) SetLat(f float64) *PhysicalEventCreate {
	pec.mutation.SetLat(f)
	return pec
}

// SetLocation sets the "location" field.
func (pec *PhysicalEventCreate) SetLocation(s string) *PhysicalEventCreate {
	pec.mutation.SetLocation(s)
	return pec
}

// SetID sets the "id" field.
func (pec *PhysicalEventCreate) SetID(s string) *PhysicalEventCreate {
	pec.mutation.SetID(s)
	return pec
}

// SetNillableID sets the "id" field if the given value is not nil.
func (pec *PhysicalEventCreate) SetNillableID(s *string) *PhysicalEventCreate {
	if s != nil {
		pec.SetID(*s)
	}
	return pec
}

// SetEventID sets the "event" edge to the Event entity by ID.
func (pec *PhysicalEventCreate) SetEventID(id string) *PhysicalEventCreate {
	pec.mutation.SetEventID(id)
	return pec
}

// SetNillableEventID sets the "event" edge to the Event entity by ID if the given value is not nil.
func (pec *PhysicalEventCreate) SetNillableEventID(id *string) *PhysicalEventCreate {
	if id != nil {
		pec = pec.SetEventID(*id)
	}
	return pec
}

// SetEvent sets the "event" edge to the Event entity.
func (pec *PhysicalEventCreate) SetEvent(e *Event) *PhysicalEventCreate {
	return pec.SetEventID(e.ID)
}

// Mutation returns the PhysicalEventMutation object of the builder.
func (pec *PhysicalEventCreate) Mutation() *PhysicalEventMutation {
	return pec.mutation
}

// Save creates the PhysicalEvent in the database.
func (pec *PhysicalEventCreate) Save(ctx context.Context) (*PhysicalEvent, error) {
	pec.defaults()
	return withHooks(ctx, pec.sqlSave, pec.mutation, pec.hooks)
}

// SaveX calls Save and panics if Save returns an error.
func (pec *PhysicalEventCreate) SaveX(ctx context.Context) *PhysicalEvent {
	v, err := pec.Save(ctx)
	if err != nil {
		panic(err)
	}
	return v
}

// Exec executes the query.
func (pec *PhysicalEventCreate) Exec(ctx context.Context) error {
	_, err := pec.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (pec *PhysicalEventCreate) ExecX(ctx context.Context) {
	if err := pec.Exec(ctx); err != nil {
		panic(err)
	}
}

// defaults sets the default values of the builder before save.
func (pec *PhysicalEventCreate) defaults() {
	if _, ok := pec.mutation.ID(); !ok {
		v := physicalevent.DefaultID()
		pec.mutation.SetID(v)
	}
}

// check runs all checks and user-defined validators on the builder.
func (pec *PhysicalEventCreate) check() error {
	if _, ok := pec.mutation.Lng(); !ok {
		return &ValidationError{Name: "lng", err: errors.New(`ent: missing required field "PhysicalEvent.lng"`)}
	}
	if _, ok := pec.mutation.Lat(); !ok {
		return &ValidationError{Name: "lat", err: errors.New(`ent: missing required field "PhysicalEvent.lat"`)}
	}
	if _, ok := pec.mutation.Location(); !ok {
		return &ValidationError{Name: "location", err: errors.New(`ent: missing required field "PhysicalEvent.location"`)}
	}
	return nil
}

func (pec *PhysicalEventCreate) sqlSave(ctx context.Context) (*PhysicalEvent, error) {
	if err := pec.check(); err != nil {
		return nil, err
	}
	_node, _spec := pec.createSpec()
	if err := sqlgraph.CreateNode(ctx, pec.driver, _spec); err != nil {
		if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return nil, err
	}
	if _spec.ID.Value != nil {
		if id, ok := _spec.ID.Value.(string); ok {
			_node.ID = id
		} else {
			return nil, fmt.Errorf("unexpected PhysicalEvent.ID type: %T", _spec.ID.Value)
		}
	}
	pec.mutation.id = &_node.ID
	pec.mutation.done = true
	return _node, nil
}

func (pec *PhysicalEventCreate) createSpec() (*PhysicalEvent, *sqlgraph.CreateSpec) {
	var (
		_node = &PhysicalEvent{config: pec.config}
		_spec = sqlgraph.NewCreateSpec(physicalevent.Table, sqlgraph.NewFieldSpec(physicalevent.FieldID, field.TypeString))
	)
	if id, ok := pec.mutation.ID(); ok {
		_node.ID = id
		_spec.ID.Value = id
	}
	if value, ok := pec.mutation.Lng(); ok {
		_spec.SetField(physicalevent.FieldLng, field.TypeFloat64, value)
		_node.Lng = value
	}
	if value, ok := pec.mutation.Lat(); ok {
		_spec.SetField(physicalevent.FieldLat, field.TypeFloat64, value)
		_node.Lat = value
	}
	if value, ok := pec.mutation.Location(); ok {
		_spec.SetField(physicalevent.FieldLocation, field.TypeString, value)
		_node.Location = value
	}
	if nodes := pec.mutation.EventIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2O,
			Inverse: true,
			Table:   physicalevent.EventTable,
			Columns: []string{physicalevent.EventColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(event.FieldID, field.TypeString),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_node.event_physical_event = &nodes[0]
		_spec.Edges = append(_spec.Edges, edge)
	}
	return _node, _spec
}

// PhysicalEventCreateBulk is the builder for creating many PhysicalEvent entities in bulk.
type PhysicalEventCreateBulk struct {
	config
	err      error
	builders []*PhysicalEventCreate
}

// Save creates the PhysicalEvent entities in the database.
func (pecb *PhysicalEventCreateBulk) Save(ctx context.Context) ([]*PhysicalEvent, error) {
	if pecb.err != nil {
		return nil, pecb.err
	}
	specs := make([]*sqlgraph.CreateSpec, len(pecb.builders))
	nodes := make([]*PhysicalEvent, len(pecb.builders))
	mutators := make([]Mutator, len(pecb.builders))
	for i := range pecb.builders {
		func(i int, root context.Context) {
			builder := pecb.builders[i]
			builder.defaults()
			var mut Mutator = MutateFunc(func(ctx context.Context, m Mutation) (Value, error) {
				mutation, ok := m.(*PhysicalEventMutation)
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
					_, err = mutators[i+1].Mutate(root, pecb.builders[i+1].mutation)
				} else {
					spec := &sqlgraph.BatchCreateSpec{Nodes: specs}
					// Invoke the actual operation on the latest mutation in the chain.
					if err = sqlgraph.BatchCreate(ctx, pecb.driver, spec); err != nil {
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
		if _, err := mutators[0].Mutate(ctx, pecb.builders[0].mutation); err != nil {
			return nil, err
		}
	}
	return nodes, nil
}

// SaveX is like Save, but panics if an error occurs.
func (pecb *PhysicalEventCreateBulk) SaveX(ctx context.Context) []*PhysicalEvent {
	v, err := pecb.Save(ctx)
	if err != nil {
		panic(err)
	}
	return v
}

// Exec executes the query.
func (pecb *PhysicalEventCreateBulk) Exec(ctx context.Context) error {
	_, err := pecb.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (pecb *PhysicalEventCreateBulk) ExecX(ctx context.Context) {
	if err := pecb.Exec(ctx); err != nil {
		panic(err)
	}
}
