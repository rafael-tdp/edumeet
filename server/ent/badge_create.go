// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"edumeet/ent/badge"
	"edumeet/ent/user"
	"errors"
	"fmt"

	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
)

// BadgeCreate is the builder for creating a Badge entity.
type BadgeCreate struct {
	config
	mutation *BadgeMutation
	hooks    []Hook
}

// SetName sets the "name" field.
func (bc *BadgeCreate) SetName(s string) *BadgeCreate {
	bc.mutation.SetName(s)
	return bc
}

// SetSvg sets the "svg" field.
func (bc *BadgeCreate) SetSvg(s string) *BadgeCreate {
	bc.mutation.SetSvg(s)
	return bc
}

// SetNbRequirementEvent sets the "nbRequirementEvent" field.
func (bc *BadgeCreate) SetNbRequirementEvent(i int) *BadgeCreate {
	bc.mutation.SetNbRequirementEvent(i)
	return bc
}

// SetType sets the "type" field.
func (bc *BadgeCreate) SetType(s string) *BadgeCreate {
	bc.mutation.SetType(s)
	return bc
}

// SetID sets the "id" field.
func (bc *BadgeCreate) SetID(s string) *BadgeCreate {
	bc.mutation.SetID(s)
	return bc
}

// SetNillableID sets the "id" field if the given value is not nil.
func (bc *BadgeCreate) SetNillableID(s *string) *BadgeCreate {
	if s != nil {
		bc.SetID(*s)
	}
	return bc
}

// AddUserIDs adds the "users" edge to the User entity by IDs.
func (bc *BadgeCreate) AddUserIDs(ids ...string) *BadgeCreate {
	bc.mutation.AddUserIDs(ids...)
	return bc
}

// AddUsers adds the "users" edges to the User entity.
func (bc *BadgeCreate) AddUsers(u ...*User) *BadgeCreate {
	ids := make([]string, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return bc.AddUserIDs(ids...)
}

// Mutation returns the BadgeMutation object of the builder.
func (bc *BadgeCreate) Mutation() *BadgeMutation {
	return bc.mutation
}

// Save creates the Badge in the database.
func (bc *BadgeCreate) Save(ctx context.Context) (*Badge, error) {
	bc.defaults()
	return withHooks(ctx, bc.sqlSave, bc.mutation, bc.hooks)
}

// SaveX calls Save and panics if Save returns an error.
func (bc *BadgeCreate) SaveX(ctx context.Context) *Badge {
	v, err := bc.Save(ctx)
	if err != nil {
		panic(err)
	}
	return v
}

// Exec executes the query.
func (bc *BadgeCreate) Exec(ctx context.Context) error {
	_, err := bc.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (bc *BadgeCreate) ExecX(ctx context.Context) {
	if err := bc.Exec(ctx); err != nil {
		panic(err)
	}
}

// defaults sets the default values of the builder before save.
func (bc *BadgeCreate) defaults() {
	if _, ok := bc.mutation.ID(); !ok {
		v := badge.DefaultID()
		bc.mutation.SetID(v)
	}
}

// check runs all checks and user-defined validators on the builder.
func (bc *BadgeCreate) check() error {
	if _, ok := bc.mutation.Name(); !ok {
		return &ValidationError{Name: "name", err: errors.New(`ent: missing required field "Badge.name"`)}
	}
	if _, ok := bc.mutation.Svg(); !ok {
		return &ValidationError{Name: "svg", err: errors.New(`ent: missing required field "Badge.svg"`)}
	}
	if _, ok := bc.mutation.NbRequirementEvent(); !ok {
		return &ValidationError{Name: "nbRequirementEvent", err: errors.New(`ent: missing required field "Badge.nbRequirementEvent"`)}
	}
	if _, ok := bc.mutation.GetType(); !ok {
		return &ValidationError{Name: "type", err: errors.New(`ent: missing required field "Badge.type"`)}
	}
	return nil
}

func (bc *BadgeCreate) sqlSave(ctx context.Context) (*Badge, error) {
	if err := bc.check(); err != nil {
		return nil, err
	}
	_node, _spec := bc.createSpec()
	if err := sqlgraph.CreateNode(ctx, bc.driver, _spec); err != nil {
		if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return nil, err
	}
	if _spec.ID.Value != nil {
		if id, ok := _spec.ID.Value.(string); ok {
			_node.ID = id
		} else {
			return nil, fmt.Errorf("unexpected Badge.ID type: %T", _spec.ID.Value)
		}
	}
	bc.mutation.id = &_node.ID
	bc.mutation.done = true
	return _node, nil
}

func (bc *BadgeCreate) createSpec() (*Badge, *sqlgraph.CreateSpec) {
	var (
		_node = &Badge{config: bc.config}
		_spec = sqlgraph.NewCreateSpec(badge.Table, sqlgraph.NewFieldSpec(badge.FieldID, field.TypeString))
	)
	if id, ok := bc.mutation.ID(); ok {
		_node.ID = id
		_spec.ID.Value = id
	}
	if value, ok := bc.mutation.Name(); ok {
		_spec.SetField(badge.FieldName, field.TypeString, value)
		_node.Name = value
	}
	if value, ok := bc.mutation.Svg(); ok {
		_spec.SetField(badge.FieldSvg, field.TypeString, value)
		_node.Svg = value
	}
	if value, ok := bc.mutation.NbRequirementEvent(); ok {
		_spec.SetField(badge.FieldNbRequirementEvent, field.TypeInt, value)
		_node.NbRequirementEvent = value
	}
	if value, ok := bc.mutation.GetType(); ok {
		_spec.SetField(badge.FieldType, field.TypeString, value)
		_node.Type = value
	}
	if nodes := bc.mutation.UsersIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: true,
			Table:   badge.UsersTable,
			Columns: badge.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeString),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges = append(_spec.Edges, edge)
	}
	return _node, _spec
}

// BadgeCreateBulk is the builder for creating many Badge entities in bulk.
type BadgeCreateBulk struct {
	config
	err      error
	builders []*BadgeCreate
}

// Save creates the Badge entities in the database.
func (bcb *BadgeCreateBulk) Save(ctx context.Context) ([]*Badge, error) {
	if bcb.err != nil {
		return nil, bcb.err
	}
	specs := make([]*sqlgraph.CreateSpec, len(bcb.builders))
	nodes := make([]*Badge, len(bcb.builders))
	mutators := make([]Mutator, len(bcb.builders))
	for i := range bcb.builders {
		func(i int, root context.Context) {
			builder := bcb.builders[i]
			builder.defaults()
			var mut Mutator = MutateFunc(func(ctx context.Context, m Mutation) (Value, error) {
				mutation, ok := m.(*BadgeMutation)
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
					_, err = mutators[i+1].Mutate(root, bcb.builders[i+1].mutation)
				} else {
					spec := &sqlgraph.BatchCreateSpec{Nodes: specs}
					// Invoke the actual operation on the latest mutation in the chain.
					if err = sqlgraph.BatchCreate(ctx, bcb.driver, spec); err != nil {
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
		if _, err := mutators[0].Mutate(ctx, bcb.builders[0].mutation); err != nil {
			return nil, err
		}
	}
	return nodes, nil
}

// SaveX is like Save, but panics if an error occurs.
func (bcb *BadgeCreateBulk) SaveX(ctx context.Context) []*Badge {
	v, err := bcb.Save(ctx)
	if err != nil {
		panic(err)
	}
	return v
}

// Exec executes the query.
func (bcb *BadgeCreateBulk) Exec(ctx context.Context) error {
	_, err := bcb.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (bcb *BadgeCreateBulk) ExecX(ctx context.Context) {
	if err := bcb.Exec(ctx); err != nil {
		panic(err)
	}
}
