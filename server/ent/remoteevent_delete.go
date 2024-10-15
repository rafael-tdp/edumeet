// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"edumeet/ent/predicate"
	"edumeet/ent/remoteevent"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
)

// RemoteEventDelete is the builder for deleting a RemoteEvent entity.
type RemoteEventDelete struct {
	config
	hooks    []Hook
	mutation *RemoteEventMutation
}

// Where appends a list predicates to the RemoteEventDelete builder.
func (red *RemoteEventDelete) Where(ps ...predicate.RemoteEvent) *RemoteEventDelete {
	red.mutation.Where(ps...)
	return red
}

// Exec executes the deletion query and returns how many vertices were deleted.
func (red *RemoteEventDelete) Exec(ctx context.Context) (int, error) {
	return withHooks(ctx, red.sqlExec, red.mutation, red.hooks)
}

// ExecX is like Exec, but panics if an error occurs.
func (red *RemoteEventDelete) ExecX(ctx context.Context) int {
	n, err := red.Exec(ctx)
	if err != nil {
		panic(err)
	}
	return n
}

func (red *RemoteEventDelete) sqlExec(ctx context.Context) (int, error) {
	_spec := sqlgraph.NewDeleteSpec(remoteevent.Table, sqlgraph.NewFieldSpec(remoteevent.FieldID, field.TypeString))
	if ps := red.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	affected, err := sqlgraph.DeleteNodes(ctx, red.driver, _spec)
	if err != nil && sqlgraph.IsConstraintError(err) {
		err = &ConstraintError{msg: err.Error(), wrap: err}
	}
	red.mutation.done = true
	return affected, err
}

// RemoteEventDeleteOne is the builder for deleting a single RemoteEvent entity.
type RemoteEventDeleteOne struct {
	red *RemoteEventDelete
}

// Where appends a list predicates to the RemoteEventDelete builder.
func (redo *RemoteEventDeleteOne) Where(ps ...predicate.RemoteEvent) *RemoteEventDeleteOne {
	redo.red.mutation.Where(ps...)
	return redo
}

// Exec executes the deletion query.
func (redo *RemoteEventDeleteOne) Exec(ctx context.Context) error {
	n, err := redo.red.Exec(ctx)
	switch {
	case err != nil:
		return err
	case n == 0:
		return &NotFoundError{remoteevent.Label}
	default:
		return nil
	}
}

// ExecX is like Exec, but panics if an error occurs.
func (redo *RemoteEventDeleteOne) ExecX(ctx context.Context) {
	if err := redo.Exec(ctx); err != nil {
		panic(err)
	}
}
