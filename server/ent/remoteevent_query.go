// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"edumeet/ent/event"
	"edumeet/ent/predicate"
	"edumeet/ent/remoteevent"
	"fmt"
	"math"

	"entgo.io/ent"
	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
)

// RemoteEventQuery is the builder for querying RemoteEvent entities.
type RemoteEventQuery struct {
	config
	ctx        *QueryContext
	order      []remoteevent.OrderOption
	inters     []Interceptor
	predicates []predicate.RemoteEvent
	withEvent  *EventQuery
	withFKs    bool
	// intermediate query (i.e. traversal path).
	sql  *sql.Selector
	path func(context.Context) (*sql.Selector, error)
}

// Where adds a new predicate for the RemoteEventQuery builder.
func (req *RemoteEventQuery) Where(ps ...predicate.RemoteEvent) *RemoteEventQuery {
	req.predicates = append(req.predicates, ps...)
	return req
}

// Limit the number of records to be returned by this query.
func (req *RemoteEventQuery) Limit(limit int) *RemoteEventQuery {
	req.ctx.Limit = &limit
	return req
}

// Offset to start from.
func (req *RemoteEventQuery) Offset(offset int) *RemoteEventQuery {
	req.ctx.Offset = &offset
	return req
}

// Unique configures the query builder to filter duplicate records on query.
// By default, unique is set to true, and can be disabled using this method.
func (req *RemoteEventQuery) Unique(unique bool) *RemoteEventQuery {
	req.ctx.Unique = &unique
	return req
}

// Order specifies how the records should be ordered.
func (req *RemoteEventQuery) Order(o ...remoteevent.OrderOption) *RemoteEventQuery {
	req.order = append(req.order, o...)
	return req
}

// QueryEvent chains the current query on the "event" edge.
func (req *RemoteEventQuery) QueryEvent() *EventQuery {
	query := (&EventClient{config: req.config}).Query()
	query.path = func(ctx context.Context) (fromU *sql.Selector, err error) {
		if err := req.prepareQuery(ctx); err != nil {
			return nil, err
		}
		selector := req.sqlQuery(ctx)
		if err := selector.Err(); err != nil {
			return nil, err
		}
		step := sqlgraph.NewStep(
			sqlgraph.From(remoteevent.Table, remoteevent.FieldID, selector),
			sqlgraph.To(event.Table, event.FieldID),
			sqlgraph.Edge(sqlgraph.O2O, true, remoteevent.EventTable, remoteevent.EventColumn),
		)
		fromU = sqlgraph.SetNeighbors(req.driver.Dialect(), step)
		return fromU, nil
	}
	return query
}

// First returns the first RemoteEvent entity from the query.
// Returns a *NotFoundError when no RemoteEvent was found.
func (req *RemoteEventQuery) First(ctx context.Context) (*RemoteEvent, error) {
	nodes, err := req.Limit(1).All(setContextOp(ctx, req.ctx, ent.OpQueryFirst))
	if err != nil {
		return nil, err
	}
	if len(nodes) == 0 {
		return nil, &NotFoundError{remoteevent.Label}
	}
	return nodes[0], nil
}

// FirstX is like First, but panics if an error occurs.
func (req *RemoteEventQuery) FirstX(ctx context.Context) *RemoteEvent {
	node, err := req.First(ctx)
	if err != nil && !IsNotFound(err) {
		panic(err)
	}
	return node
}

// FirstID returns the first RemoteEvent ID from the query.
// Returns a *NotFoundError when no RemoteEvent ID was found.
func (req *RemoteEventQuery) FirstID(ctx context.Context) (id string, err error) {
	var ids []string
	if ids, err = req.Limit(1).IDs(setContextOp(ctx, req.ctx, ent.OpQueryFirstID)); err != nil {
		return
	}
	if len(ids) == 0 {
		err = &NotFoundError{remoteevent.Label}
		return
	}
	return ids[0], nil
}

// FirstIDX is like FirstID, but panics if an error occurs.
func (req *RemoteEventQuery) FirstIDX(ctx context.Context) string {
	id, err := req.FirstID(ctx)
	if err != nil && !IsNotFound(err) {
		panic(err)
	}
	return id
}

// Only returns a single RemoteEvent entity found by the query, ensuring it only returns one.
// Returns a *NotSingularError when more than one RemoteEvent entity is found.
// Returns a *NotFoundError when no RemoteEvent entities are found.
func (req *RemoteEventQuery) Only(ctx context.Context) (*RemoteEvent, error) {
	nodes, err := req.Limit(2).All(setContextOp(ctx, req.ctx, ent.OpQueryOnly))
	if err != nil {
		return nil, err
	}
	switch len(nodes) {
	case 1:
		return nodes[0], nil
	case 0:
		return nil, &NotFoundError{remoteevent.Label}
	default:
		return nil, &NotSingularError{remoteevent.Label}
	}
}

// OnlyX is like Only, but panics if an error occurs.
func (req *RemoteEventQuery) OnlyX(ctx context.Context) *RemoteEvent {
	node, err := req.Only(ctx)
	if err != nil {
		panic(err)
	}
	return node
}

// OnlyID is like Only, but returns the only RemoteEvent ID in the query.
// Returns a *NotSingularError when more than one RemoteEvent ID is found.
// Returns a *NotFoundError when no entities are found.
func (req *RemoteEventQuery) OnlyID(ctx context.Context) (id string, err error) {
	var ids []string
	if ids, err = req.Limit(2).IDs(setContextOp(ctx, req.ctx, ent.OpQueryOnlyID)); err != nil {
		return
	}
	switch len(ids) {
	case 1:
		id = ids[0]
	case 0:
		err = &NotFoundError{remoteevent.Label}
	default:
		err = &NotSingularError{remoteevent.Label}
	}
	return
}

// OnlyIDX is like OnlyID, but panics if an error occurs.
func (req *RemoteEventQuery) OnlyIDX(ctx context.Context) string {
	id, err := req.OnlyID(ctx)
	if err != nil {
		panic(err)
	}
	return id
}

// All executes the query and returns a list of RemoteEvents.
func (req *RemoteEventQuery) All(ctx context.Context) ([]*RemoteEvent, error) {
	ctx = setContextOp(ctx, req.ctx, ent.OpQueryAll)
	if err := req.prepareQuery(ctx); err != nil {
		return nil, err
	}
	qr := querierAll[[]*RemoteEvent, *RemoteEventQuery]()
	return withInterceptors[[]*RemoteEvent](ctx, req, qr, req.inters)
}

// AllX is like All, but panics if an error occurs.
func (req *RemoteEventQuery) AllX(ctx context.Context) []*RemoteEvent {
	nodes, err := req.All(ctx)
	if err != nil {
		panic(err)
	}
	return nodes
}

// IDs executes the query and returns a list of RemoteEvent IDs.
func (req *RemoteEventQuery) IDs(ctx context.Context) (ids []string, err error) {
	if req.ctx.Unique == nil && req.path != nil {
		req.Unique(true)
	}
	ctx = setContextOp(ctx, req.ctx, ent.OpQueryIDs)
	if err = req.Select(remoteevent.FieldID).Scan(ctx, &ids); err != nil {
		return nil, err
	}
	return ids, nil
}

// IDsX is like IDs, but panics if an error occurs.
func (req *RemoteEventQuery) IDsX(ctx context.Context) []string {
	ids, err := req.IDs(ctx)
	if err != nil {
		panic(err)
	}
	return ids
}

// Count returns the count of the given query.
func (req *RemoteEventQuery) Count(ctx context.Context) (int, error) {
	ctx = setContextOp(ctx, req.ctx, ent.OpQueryCount)
	if err := req.prepareQuery(ctx); err != nil {
		return 0, err
	}
	return withInterceptors[int](ctx, req, querierCount[*RemoteEventQuery](), req.inters)
}

// CountX is like Count, but panics if an error occurs.
func (req *RemoteEventQuery) CountX(ctx context.Context) int {
	count, err := req.Count(ctx)
	if err != nil {
		panic(err)
	}
	return count
}

// Exist returns true if the query has elements in the graph.
func (req *RemoteEventQuery) Exist(ctx context.Context) (bool, error) {
	ctx = setContextOp(ctx, req.ctx, ent.OpQueryExist)
	switch _, err := req.FirstID(ctx); {
	case IsNotFound(err):
		return false, nil
	case err != nil:
		return false, fmt.Errorf("ent: check existence: %w", err)
	default:
		return true, nil
	}
}

// ExistX is like Exist, but panics if an error occurs.
func (req *RemoteEventQuery) ExistX(ctx context.Context) bool {
	exist, err := req.Exist(ctx)
	if err != nil {
		panic(err)
	}
	return exist
}

// Clone returns a duplicate of the RemoteEventQuery builder, including all associated steps. It can be
// used to prepare common query builders and use them differently after the clone is made.
func (req *RemoteEventQuery) Clone() *RemoteEventQuery {
	if req == nil {
		return nil
	}
	return &RemoteEventQuery{
		config:     req.config,
		ctx:        req.ctx.Clone(),
		order:      append([]remoteevent.OrderOption{}, req.order...),
		inters:     append([]Interceptor{}, req.inters...),
		predicates: append([]predicate.RemoteEvent{}, req.predicates...),
		withEvent:  req.withEvent.Clone(),
		// clone intermediate query.
		sql:  req.sql.Clone(),
		path: req.path,
	}
}

// WithEvent tells the query-builder to eager-load the nodes that are connected to
// the "event" edge. The optional arguments are used to configure the query builder of the edge.
func (req *RemoteEventQuery) WithEvent(opts ...func(*EventQuery)) *RemoteEventQuery {
	query := (&EventClient{config: req.config}).Query()
	for _, opt := range opts {
		opt(query)
	}
	req.withEvent = query
	return req
}

// GroupBy is used to group vertices by one or more fields/columns.
// It is often used with aggregate functions, like: count, max, mean, min, sum.
//
// Example:
//
//	var v []struct {
//		URL string `json:"url,omitempty"`
//		Count int `json:"count,omitempty"`
//	}
//
//	client.RemoteEvent.Query().
//		GroupBy(remoteevent.FieldURL).
//		Aggregate(ent.Count()).
//		Scan(ctx, &v)
func (req *RemoteEventQuery) GroupBy(field string, fields ...string) *RemoteEventGroupBy {
	req.ctx.Fields = append([]string{field}, fields...)
	grbuild := &RemoteEventGroupBy{build: req}
	grbuild.flds = &req.ctx.Fields
	grbuild.label = remoteevent.Label
	grbuild.scan = grbuild.Scan
	return grbuild
}

// Select allows the selection one or more fields/columns for the given query,
// instead of selecting all fields in the entity.
//
// Example:
//
//	var v []struct {
//		URL string `json:"url,omitempty"`
//	}
//
//	client.RemoteEvent.Query().
//		Select(remoteevent.FieldURL).
//		Scan(ctx, &v)
func (req *RemoteEventQuery) Select(fields ...string) *RemoteEventSelect {
	req.ctx.Fields = append(req.ctx.Fields, fields...)
	sbuild := &RemoteEventSelect{RemoteEventQuery: req}
	sbuild.label = remoteevent.Label
	sbuild.flds, sbuild.scan = &req.ctx.Fields, sbuild.Scan
	return sbuild
}

// Aggregate returns a RemoteEventSelect configured with the given aggregations.
func (req *RemoteEventQuery) Aggregate(fns ...AggregateFunc) *RemoteEventSelect {
	return req.Select().Aggregate(fns...)
}

func (req *RemoteEventQuery) prepareQuery(ctx context.Context) error {
	for _, inter := range req.inters {
		if inter == nil {
			return fmt.Errorf("ent: uninitialized interceptor (forgotten import ent/runtime?)")
		}
		if trv, ok := inter.(Traverser); ok {
			if err := trv.Traverse(ctx, req); err != nil {
				return err
			}
		}
	}
	for _, f := range req.ctx.Fields {
		if !remoteevent.ValidColumn(f) {
			return &ValidationError{Name: f, err: fmt.Errorf("ent: invalid field %q for query", f)}
		}
	}
	if req.path != nil {
		prev, err := req.path(ctx)
		if err != nil {
			return err
		}
		req.sql = prev
	}
	return nil
}

func (req *RemoteEventQuery) sqlAll(ctx context.Context, hooks ...queryHook) ([]*RemoteEvent, error) {
	var (
		nodes       = []*RemoteEvent{}
		withFKs     = req.withFKs
		_spec       = req.querySpec()
		loadedTypes = [1]bool{
			req.withEvent != nil,
		}
	)
	if req.withEvent != nil {
		withFKs = true
	}
	if withFKs {
		_spec.Node.Columns = append(_spec.Node.Columns, remoteevent.ForeignKeys...)
	}
	_spec.ScanValues = func(columns []string) ([]any, error) {
		return (*RemoteEvent).scanValues(nil, columns)
	}
	_spec.Assign = func(columns []string, values []any) error {
		node := &RemoteEvent{config: req.config}
		nodes = append(nodes, node)
		node.Edges.loadedTypes = loadedTypes
		return node.assignValues(columns, values)
	}
	for i := range hooks {
		hooks[i](ctx, _spec)
	}
	if err := sqlgraph.QueryNodes(ctx, req.driver, _spec); err != nil {
		return nil, err
	}
	if len(nodes) == 0 {
		return nodes, nil
	}
	if query := req.withEvent; query != nil {
		if err := req.loadEvent(ctx, query, nodes, nil,
			func(n *RemoteEvent, e *Event) { n.Edges.Event = e }); err != nil {
			return nil, err
		}
	}
	return nodes, nil
}

func (req *RemoteEventQuery) loadEvent(ctx context.Context, query *EventQuery, nodes []*RemoteEvent, init func(*RemoteEvent), assign func(*RemoteEvent, *Event)) error {
	ids := make([]string, 0, len(nodes))
	nodeids := make(map[string][]*RemoteEvent)
	for i := range nodes {
		if nodes[i].event_remote_event == nil {
			continue
		}
		fk := *nodes[i].event_remote_event
		if _, ok := nodeids[fk]; !ok {
			ids = append(ids, fk)
		}
		nodeids[fk] = append(nodeids[fk], nodes[i])
	}
	if len(ids) == 0 {
		return nil
	}
	query.Where(event.IDIn(ids...))
	neighbors, err := query.All(ctx)
	if err != nil {
		return err
	}
	for _, n := range neighbors {
		nodes, ok := nodeids[n.ID]
		if !ok {
			return fmt.Errorf(`unexpected foreign-key "event_remote_event" returned %v`, n.ID)
		}
		for i := range nodes {
			assign(nodes[i], n)
		}
	}
	return nil
}

func (req *RemoteEventQuery) sqlCount(ctx context.Context) (int, error) {
	_spec := req.querySpec()
	_spec.Node.Columns = req.ctx.Fields
	if len(req.ctx.Fields) > 0 {
		_spec.Unique = req.ctx.Unique != nil && *req.ctx.Unique
	}
	return sqlgraph.CountNodes(ctx, req.driver, _spec)
}

func (req *RemoteEventQuery) querySpec() *sqlgraph.QuerySpec {
	_spec := sqlgraph.NewQuerySpec(remoteevent.Table, remoteevent.Columns, sqlgraph.NewFieldSpec(remoteevent.FieldID, field.TypeString))
	_spec.From = req.sql
	if unique := req.ctx.Unique; unique != nil {
		_spec.Unique = *unique
	} else if req.path != nil {
		_spec.Unique = true
	}
	if fields := req.ctx.Fields; len(fields) > 0 {
		_spec.Node.Columns = make([]string, 0, len(fields))
		_spec.Node.Columns = append(_spec.Node.Columns, remoteevent.FieldID)
		for i := range fields {
			if fields[i] != remoteevent.FieldID {
				_spec.Node.Columns = append(_spec.Node.Columns, fields[i])
			}
		}
	}
	if ps := req.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	if limit := req.ctx.Limit; limit != nil {
		_spec.Limit = *limit
	}
	if offset := req.ctx.Offset; offset != nil {
		_spec.Offset = *offset
	}
	if ps := req.order; len(ps) > 0 {
		_spec.Order = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	return _spec
}

func (req *RemoteEventQuery) sqlQuery(ctx context.Context) *sql.Selector {
	builder := sql.Dialect(req.driver.Dialect())
	t1 := builder.Table(remoteevent.Table)
	columns := req.ctx.Fields
	if len(columns) == 0 {
		columns = remoteevent.Columns
	}
	selector := builder.Select(t1.Columns(columns...)...).From(t1)
	if req.sql != nil {
		selector = req.sql
		selector.Select(selector.Columns(columns...)...)
	}
	if req.ctx.Unique != nil && *req.ctx.Unique {
		selector.Distinct()
	}
	for _, p := range req.predicates {
		p(selector)
	}
	for _, p := range req.order {
		p(selector)
	}
	if offset := req.ctx.Offset; offset != nil {
		// limit is mandatory for offset clause. We start
		// with default value, and override it below if needed.
		selector.Offset(*offset).Limit(math.MaxInt32)
	}
	if limit := req.ctx.Limit; limit != nil {
		selector.Limit(*limit)
	}
	return selector
}

// RemoteEventGroupBy is the group-by builder for RemoteEvent entities.
type RemoteEventGroupBy struct {
	selector
	build *RemoteEventQuery
}

// Aggregate adds the given aggregation functions to the group-by query.
func (regb *RemoteEventGroupBy) Aggregate(fns ...AggregateFunc) *RemoteEventGroupBy {
	regb.fns = append(regb.fns, fns...)
	return regb
}

// Scan applies the selector query and scans the result into the given value.
func (regb *RemoteEventGroupBy) Scan(ctx context.Context, v any) error {
	ctx = setContextOp(ctx, regb.build.ctx, ent.OpQueryGroupBy)
	if err := regb.build.prepareQuery(ctx); err != nil {
		return err
	}
	return scanWithInterceptors[*RemoteEventQuery, *RemoteEventGroupBy](ctx, regb.build, regb, regb.build.inters, v)
}

func (regb *RemoteEventGroupBy) sqlScan(ctx context.Context, root *RemoteEventQuery, v any) error {
	selector := root.sqlQuery(ctx).Select()
	aggregation := make([]string, 0, len(regb.fns))
	for _, fn := range regb.fns {
		aggregation = append(aggregation, fn(selector))
	}
	if len(selector.SelectedColumns()) == 0 {
		columns := make([]string, 0, len(*regb.flds)+len(regb.fns))
		for _, f := range *regb.flds {
			columns = append(columns, selector.C(f))
		}
		columns = append(columns, aggregation...)
		selector.Select(columns...)
	}
	selector.GroupBy(selector.Columns(*regb.flds...)...)
	if err := selector.Err(); err != nil {
		return err
	}
	rows := &sql.Rows{}
	query, args := selector.Query()
	if err := regb.build.driver.Query(ctx, query, args, rows); err != nil {
		return err
	}
	defer rows.Close()
	return sql.ScanSlice(rows, v)
}

// RemoteEventSelect is the builder for selecting fields of RemoteEvent entities.
type RemoteEventSelect struct {
	*RemoteEventQuery
	selector
}

// Aggregate adds the given aggregation functions to the selector query.
func (res *RemoteEventSelect) Aggregate(fns ...AggregateFunc) *RemoteEventSelect {
	res.fns = append(res.fns, fns...)
	return res
}

// Scan applies the selector query and scans the result into the given value.
func (res *RemoteEventSelect) Scan(ctx context.Context, v any) error {
	ctx = setContextOp(ctx, res.ctx, ent.OpQuerySelect)
	if err := res.prepareQuery(ctx); err != nil {
		return err
	}
	return scanWithInterceptors[*RemoteEventQuery, *RemoteEventSelect](ctx, res.RemoteEventQuery, res, res.inters, v)
}

func (res *RemoteEventSelect) sqlScan(ctx context.Context, root *RemoteEventQuery, v any) error {
	selector := root.sqlQuery(ctx)
	aggregation := make([]string, 0, len(res.fns))
	for _, fn := range res.fns {
		aggregation = append(aggregation, fn(selector))
	}
	switch n := len(*res.selector.flds); {
	case n == 0 && len(aggregation) > 0:
		selector.Select(aggregation...)
	case n != 0 && len(aggregation) > 0:
		selector.AppendSelect(aggregation...)
	}
	rows := &sql.Rows{}
	query, args := selector.Query()
	if err := res.driver.Query(ctx, query, args, rows); err != nil {
		return err
	}
	defer rows.Close()
	return sql.ScanSlice(rows, v)
}
