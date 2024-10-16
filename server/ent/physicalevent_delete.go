// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"edumeet/ent/physicalevent"
	"edumeet/ent/predicate"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
)

// PhysicalEventDelete is the builder for deleting a PhysicalEvent entity.
type PhysicalEventDelete struct {
	config
	hooks    []Hook
	mutation *PhysicalEventMutation
}

// Where appends a list predicates to the PhysicalEventDelete builder.
func (ped *PhysicalEventDelete) Where(ps ...predicate.PhysicalEvent) *PhysicalEventDelete {
	ped.mutation.Where(ps...)
	return ped
}

// Exec executes the deletion query and returns how many vertices were deleted.
func (ped *PhysicalEventDelete) Exec(ctx context.Context) (int, error) {
	return withHooks(ctx, ped.sqlExec, ped.mutation, ped.hooks)
}

// ExecX is like Exec, but panics if an error occurs.
func (ped *PhysicalEventDelete) ExecX(ctx context.Context) int {
	n, err := ped.Exec(ctx)
	if err != nil {
		panic(err)
	}
	return n
}

func (ped *PhysicalEventDelete) sqlExec(ctx context.Context) (int, error) {
	_spec := sqlgraph.NewDeleteSpec(physicalevent.Table, sqlgraph.NewFieldSpec(physicalevent.FieldID, field.TypeString))
	if ps := ped.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	affected, err := sqlgraph.DeleteNodes(ctx, ped.driver, _spec)
	if err != nil && sqlgraph.IsConstraintError(err) {
		err = &ConstraintError{msg: err.Error(), wrap: err}
	}
	ped.mutation.done = true
	return affected, err
}

// PhysicalEventDeleteOne is the builder for deleting a single PhysicalEvent entity.
type PhysicalEventDeleteOne struct {
	ped *PhysicalEventDelete
}

// Where appends a list predicates to the PhysicalEventDelete builder.
func (pedo *PhysicalEventDeleteOne) Where(ps ...predicate.PhysicalEvent) *PhysicalEventDeleteOne {
	pedo.ped.mutation.Where(ps...)
	return pedo
}

// Exec executes the deletion query.
func (pedo *PhysicalEventDeleteOne) Exec(ctx context.Context) error {
	n, err := pedo.ped.Exec(ctx)
	switch {
	case err != nil:
		return err
	case n == 0:
		return &NotFoundError{physicalevent.Label}
	default:
		return nil
	}
}

// ExecX is like Exec, but panics if an error occurs.
func (pedo *PhysicalEventDeleteOne) ExecX(ctx context.Context) {
	if err := pedo.Exec(ctx); err != nil {
		panic(err)
	}
}
