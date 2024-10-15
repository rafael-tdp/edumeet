// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"edumeet/ent/reporting"
	"edumeet/ent/user"
	"errors"
	"fmt"

	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
)

// ReportingCreate is the builder for creating a Reporting entity.
type ReportingCreate struct {
	config
	mutation *ReportingMutation
	hooks    []Hook
}

// SetReason sets the "reason" field.
func (rc *ReportingCreate) SetReason(s string) *ReportingCreate {
	rc.mutation.SetReason(s)
	return rc
}

// SetType sets the "type" field.
func (rc *ReportingCreate) SetType(s string) *ReportingCreate {
	rc.mutation.SetType(s)
	return rc
}

// SetEntityID sets the "entity_id" field.
func (rc *ReportingCreate) SetEntityID(s string) *ReportingCreate {
	rc.mutation.SetEntityID(s)
	return rc
}

// SetID sets the "id" field.
func (rc *ReportingCreate) SetID(s string) *ReportingCreate {
	rc.mutation.SetID(s)
	return rc
}

// SetNillableID sets the "id" field if the given value is not nil.
func (rc *ReportingCreate) SetNillableID(s *string) *ReportingCreate {
	if s != nil {
		rc.SetID(*s)
	}
	return rc
}

// SetUserID sets the "user" edge to the User entity by ID.
func (rc *ReportingCreate) SetUserID(id string) *ReportingCreate {
	rc.mutation.SetUserID(id)
	return rc
}

// SetNillableUserID sets the "user" edge to the User entity by ID if the given value is not nil.
func (rc *ReportingCreate) SetNillableUserID(id *string) *ReportingCreate {
	if id != nil {
		rc = rc.SetUserID(*id)
	}
	return rc
}

// SetUser sets the "user" edge to the User entity.
func (rc *ReportingCreate) SetUser(u *User) *ReportingCreate {
	return rc.SetUserID(u.ID)
}

// Mutation returns the ReportingMutation object of the builder.
func (rc *ReportingCreate) Mutation() *ReportingMutation {
	return rc.mutation
}

// Save creates the Reporting in the database.
func (rc *ReportingCreate) Save(ctx context.Context) (*Reporting, error) {
	rc.defaults()
	return withHooks(ctx, rc.sqlSave, rc.mutation, rc.hooks)
}

// SaveX calls Save and panics if Save returns an error.
func (rc *ReportingCreate) SaveX(ctx context.Context) *Reporting {
	v, err := rc.Save(ctx)
	if err != nil {
		panic(err)
	}
	return v
}

// Exec executes the query.
func (rc *ReportingCreate) Exec(ctx context.Context) error {
	_, err := rc.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (rc *ReportingCreate) ExecX(ctx context.Context) {
	if err := rc.Exec(ctx); err != nil {
		panic(err)
	}
}

// defaults sets the default values of the builder before save.
func (rc *ReportingCreate) defaults() {
	if _, ok := rc.mutation.ID(); !ok {
		v := reporting.DefaultID()
		rc.mutation.SetID(v)
	}
}

// check runs all checks and user-defined validators on the builder.
func (rc *ReportingCreate) check() error {
	if _, ok := rc.mutation.Reason(); !ok {
		return &ValidationError{Name: "reason", err: errors.New(`ent: missing required field "Reporting.reason"`)}
	}
	if _, ok := rc.mutation.GetType(); !ok {
		return &ValidationError{Name: "type", err: errors.New(`ent: missing required field "Reporting.type"`)}
	}
	if _, ok := rc.mutation.EntityID(); !ok {
		return &ValidationError{Name: "entity_id", err: errors.New(`ent: missing required field "Reporting.entity_id"`)}
	}
	return nil
}

func (rc *ReportingCreate) sqlSave(ctx context.Context) (*Reporting, error) {
	if err := rc.check(); err != nil {
		return nil, err
	}
	_node, _spec := rc.createSpec()
	if err := sqlgraph.CreateNode(ctx, rc.driver, _spec); err != nil {
		if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return nil, err
	}
	if _spec.ID.Value != nil {
		if id, ok := _spec.ID.Value.(string); ok {
			_node.ID = id
		} else {
			return nil, fmt.Errorf("unexpected Reporting.ID type: %T", _spec.ID.Value)
		}
	}
	rc.mutation.id = &_node.ID
	rc.mutation.done = true
	return _node, nil
}

func (rc *ReportingCreate) createSpec() (*Reporting, *sqlgraph.CreateSpec) {
	var (
		_node = &Reporting{config: rc.config}
		_spec = sqlgraph.NewCreateSpec(reporting.Table, sqlgraph.NewFieldSpec(reporting.FieldID, field.TypeString))
	)
	if id, ok := rc.mutation.ID(); ok {
		_node.ID = id
		_spec.ID.Value = id
	}
	if value, ok := rc.mutation.Reason(); ok {
		_spec.SetField(reporting.FieldReason, field.TypeString, value)
		_node.Reason = value
	}
	if value, ok := rc.mutation.GetType(); ok {
		_spec.SetField(reporting.FieldType, field.TypeString, value)
		_node.Type = value
	}
	if value, ok := rc.mutation.EntityID(); ok {
		_spec.SetField(reporting.FieldEntityID, field.TypeString, value)
		_node.EntityID = value
	}
	if nodes := rc.mutation.UserIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: true,
			Table:   reporting.UserTable,
			Columns: []string{reporting.UserColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeString),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_node.user_reports = &nodes[0]
		_spec.Edges = append(_spec.Edges, edge)
	}
	return _node, _spec
}

// ReportingCreateBulk is the builder for creating many Reporting entities in bulk.
type ReportingCreateBulk struct {
	config
	err      error
	builders []*ReportingCreate
}

// Save creates the Reporting entities in the database.
func (rcb *ReportingCreateBulk) Save(ctx context.Context) ([]*Reporting, error) {
	if rcb.err != nil {
		return nil, rcb.err
	}
	specs := make([]*sqlgraph.CreateSpec, len(rcb.builders))
	nodes := make([]*Reporting, len(rcb.builders))
	mutators := make([]Mutator, len(rcb.builders))
	for i := range rcb.builders {
		func(i int, root context.Context) {
			builder := rcb.builders[i]
			builder.defaults()
			var mut Mutator = MutateFunc(func(ctx context.Context, m Mutation) (Value, error) {
				mutation, ok := m.(*ReportingMutation)
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
					_, err = mutators[i+1].Mutate(root, rcb.builders[i+1].mutation)
				} else {
					spec := &sqlgraph.BatchCreateSpec{Nodes: specs}
					// Invoke the actual operation on the latest mutation in the chain.
					if err = sqlgraph.BatchCreate(ctx, rcb.driver, spec); err != nil {
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
		if _, err := mutators[0].Mutate(ctx, rcb.builders[0].mutation); err != nil {
			return nil, err
		}
	}
	return nodes, nil
}

// SaveX is like Save, but panics if an error occurs.
func (rcb *ReportingCreateBulk) SaveX(ctx context.Context) []*Reporting {
	v, err := rcb.Save(ctx)
	if err != nil {
		panic(err)
	}
	return v
}

// Exec executes the query.
func (rcb *ReportingCreateBulk) Exec(ctx context.Context) error {
	_, err := rcb.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (rcb *ReportingCreateBulk) ExecX(ctx context.Context) {
	if err := rcb.Exec(ctx); err != nil {
		panic(err)
	}
}
