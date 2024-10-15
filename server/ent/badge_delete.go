// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"edumeet/ent/badge"
	"edumeet/ent/predicate"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
)

// BadgeDelete is the builder for deleting a Badge entity.
type BadgeDelete struct {
	config
	hooks    []Hook
	mutation *BadgeMutation
}

// Where appends a list predicates to the BadgeDelete builder.
func (bd *BadgeDelete) Where(ps ...predicate.Badge) *BadgeDelete {
	bd.mutation.Where(ps...)
	return bd
}

// Exec executes the deletion query and returns how many vertices were deleted.
func (bd *BadgeDelete) Exec(ctx context.Context) (int, error) {
	return withHooks(ctx, bd.sqlExec, bd.mutation, bd.hooks)
}

// ExecX is like Exec, but panics if an error occurs.
func (bd *BadgeDelete) ExecX(ctx context.Context) int {
	n, err := bd.Exec(ctx)
	if err != nil {
		panic(err)
	}
	return n
}

func (bd *BadgeDelete) sqlExec(ctx context.Context) (int, error) {
	_spec := sqlgraph.NewDeleteSpec(badge.Table, sqlgraph.NewFieldSpec(badge.FieldID, field.TypeString))
	if ps := bd.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	affected, err := sqlgraph.DeleteNodes(ctx, bd.driver, _spec)
	if err != nil && sqlgraph.IsConstraintError(err) {
		err = &ConstraintError{msg: err.Error(), wrap: err}
	}
	bd.mutation.done = true
	return affected, err
}

// BadgeDeleteOne is the builder for deleting a single Badge entity.
type BadgeDeleteOne struct {
	bd *BadgeDelete
}

// Where appends a list predicates to the BadgeDelete builder.
func (bdo *BadgeDeleteOne) Where(ps ...predicate.Badge) *BadgeDeleteOne {
	bdo.bd.mutation.Where(ps...)
	return bdo
}

// Exec executes the deletion query.
func (bdo *BadgeDeleteOne) Exec(ctx context.Context) error {
	n, err := bdo.bd.Exec(ctx)
	switch {
	case err != nil:
		return err
	case n == 0:
		return &NotFoundError{badge.Label}
	default:
		return nil
	}
}

// ExecX is like Exec, but panics if an error occurs.
func (bdo *BadgeDeleteOne) ExecX(ctx context.Context) {
	if err := bdo.Exec(ctx); err != nil {
		panic(err)
	}
}
