// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"edumeet/ent/predicate"
	"edumeet/ent/reporting"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
)

// ReportingDelete is the builder for deleting a Reporting entity.
type ReportingDelete struct {
	config
	hooks    []Hook
	mutation *ReportingMutation
}

// Where appends a list predicates to the ReportingDelete builder.
func (rd *ReportingDelete) Where(ps ...predicate.Reporting) *ReportingDelete {
	rd.mutation.Where(ps...)
	return rd
}

// Exec executes the deletion query and returns how many vertices were deleted.
func (rd *ReportingDelete) Exec(ctx context.Context) (int, error) {
	return withHooks(ctx, rd.sqlExec, rd.mutation, rd.hooks)
}

// ExecX is like Exec, but panics if an error occurs.
func (rd *ReportingDelete) ExecX(ctx context.Context) int {
	n, err := rd.Exec(ctx)
	if err != nil {
		panic(err)
	}
	return n
}

func (rd *ReportingDelete) sqlExec(ctx context.Context) (int, error) {
	_spec := sqlgraph.NewDeleteSpec(reporting.Table, sqlgraph.NewFieldSpec(reporting.FieldID, field.TypeString))
	if ps := rd.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	affected, err := sqlgraph.DeleteNodes(ctx, rd.driver, _spec)
	if err != nil && sqlgraph.IsConstraintError(err) {
		err = &ConstraintError{msg: err.Error(), wrap: err}
	}
	rd.mutation.done = true
	return affected, err
}

// ReportingDeleteOne is the builder for deleting a single Reporting entity.
type ReportingDeleteOne struct {
	rd *ReportingDelete
}

// Where appends a list predicates to the ReportingDelete builder.
func (rdo *ReportingDeleteOne) Where(ps ...predicate.Reporting) *ReportingDeleteOne {
	rdo.rd.mutation.Where(ps...)
	return rdo
}

// Exec executes the deletion query.
func (rdo *ReportingDeleteOne) Exec(ctx context.Context) error {
	n, err := rdo.rd.Exec(ctx)
	switch {
	case err != nil:
		return err
	case n == 0:
		return &NotFoundError{reporting.Label}
	default:
		return nil
	}
}

// ExecX is like Exec, but panics if an error occurs.
func (rdo *ReportingDeleteOne) ExecX(ctx context.Context) {
	if err := rdo.Exec(ctx); err != nil {
		panic(err)
	}
}
