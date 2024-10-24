// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"edumeet/ent/document"
	"edumeet/ent/event"
	"edumeet/ent/eventdocument"
	"edumeet/ent/predicate"
	"fmt"
	"math"

	"entgo.io/ent"
	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
)

// EventDocumentQuery is the builder for querying EventDocument entities.
type EventDocumentQuery struct {
	config
	ctx          *QueryContext
	order        []eventdocument.OrderOption
	inters       []Interceptor
	predicates   []predicate.EventDocument
	withDocument *DocumentQuery
	withEvent    *EventQuery
	withFKs      bool
	// intermediate query (i.e. traversal path).
	sql  *sql.Selector
	path func(context.Context) (*sql.Selector, error)
}

// Where adds a new predicate for the EventDocumentQuery builder.
func (edq *EventDocumentQuery) Where(ps ...predicate.EventDocument) *EventDocumentQuery {
	edq.predicates = append(edq.predicates, ps...)
	return edq
}

// Limit the number of records to be returned by this query.
func (edq *EventDocumentQuery) Limit(limit int) *EventDocumentQuery {
	edq.ctx.Limit = &limit
	return edq
}

// Offset to start from.
func (edq *EventDocumentQuery) Offset(offset int) *EventDocumentQuery {
	edq.ctx.Offset = &offset
	return edq
}

// Unique configures the query builder to filter duplicate records on query.
// By default, unique is set to true, and can be disabled using this method.
func (edq *EventDocumentQuery) Unique(unique bool) *EventDocumentQuery {
	edq.ctx.Unique = &unique
	return edq
}

// Order specifies how the records should be ordered.
func (edq *EventDocumentQuery) Order(o ...eventdocument.OrderOption) *EventDocumentQuery {
	edq.order = append(edq.order, o...)
	return edq
}

// QueryDocument chains the current query on the "document" edge.
func (edq *EventDocumentQuery) QueryDocument() *DocumentQuery {
	query := (&DocumentClient{config: edq.config}).Query()
	query.path = func(ctx context.Context) (fromU *sql.Selector, err error) {
		if err := edq.prepareQuery(ctx); err != nil {
			return nil, err
		}
		selector := edq.sqlQuery(ctx)
		if err := selector.Err(); err != nil {
			return nil, err
		}
		step := sqlgraph.NewStep(
			sqlgraph.From(eventdocument.Table, eventdocument.FieldID, selector),
			sqlgraph.To(document.Table, document.FieldID),
			sqlgraph.Edge(sqlgraph.M2O, true, eventdocument.DocumentTable, eventdocument.DocumentColumn),
		)
		fromU = sqlgraph.SetNeighbors(edq.driver.Dialect(), step)
		return fromU, nil
	}
	return query
}

// QueryEvent chains the current query on the "event" edge.
func (edq *EventDocumentQuery) QueryEvent() *EventQuery {
	query := (&EventClient{config: edq.config}).Query()
	query.path = func(ctx context.Context) (fromU *sql.Selector, err error) {
		if err := edq.prepareQuery(ctx); err != nil {
			return nil, err
		}
		selector := edq.sqlQuery(ctx)
		if err := selector.Err(); err != nil {
			return nil, err
		}
		step := sqlgraph.NewStep(
			sqlgraph.From(eventdocument.Table, eventdocument.FieldID, selector),
			sqlgraph.To(event.Table, event.FieldID),
			sqlgraph.Edge(sqlgraph.M2O, true, eventdocument.EventTable, eventdocument.EventColumn),
		)
		fromU = sqlgraph.SetNeighbors(edq.driver.Dialect(), step)
		return fromU, nil
	}
	return query
}

// First returns the first EventDocument entity from the query.
// Returns a *NotFoundError when no EventDocument was found.
func (edq *EventDocumentQuery) First(ctx context.Context) (*EventDocument, error) {
	nodes, err := edq.Limit(1).All(setContextOp(ctx, edq.ctx, ent.OpQueryFirst))
	if err != nil {
		return nil, err
	}
	if len(nodes) == 0 {
		return nil, &NotFoundError{eventdocument.Label}
	}
	return nodes[0], nil
}

// FirstX is like First, but panics if an error occurs.
func (edq *EventDocumentQuery) FirstX(ctx context.Context) *EventDocument {
	node, err := edq.First(ctx)
	if err != nil && !IsNotFound(err) {
		panic(err)
	}
	return node
}

// FirstID returns the first EventDocument ID from the query.
// Returns a *NotFoundError when no EventDocument ID was found.
func (edq *EventDocumentQuery) FirstID(ctx context.Context) (id string, err error) {
	var ids []string
	if ids, err = edq.Limit(1).IDs(setContextOp(ctx, edq.ctx, ent.OpQueryFirstID)); err != nil {
		return
	}
	if len(ids) == 0 {
		err = &NotFoundError{eventdocument.Label}
		return
	}
	return ids[0], nil
}

// FirstIDX is like FirstID, but panics if an error occurs.
func (edq *EventDocumentQuery) FirstIDX(ctx context.Context) string {
	id, err := edq.FirstID(ctx)
	if err != nil && !IsNotFound(err) {
		panic(err)
	}
	return id
}

// Only returns a single EventDocument entity found by the query, ensuring it only returns one.
// Returns a *NotSingularError when more than one EventDocument entity is found.
// Returns a *NotFoundError when no EventDocument entities are found.
func (edq *EventDocumentQuery) Only(ctx context.Context) (*EventDocument, error) {
	nodes, err := edq.Limit(2).All(setContextOp(ctx, edq.ctx, ent.OpQueryOnly))
	if err != nil {
		return nil, err
	}
	switch len(nodes) {
	case 1:
		return nodes[0], nil
	case 0:
		return nil, &NotFoundError{eventdocument.Label}
	default:
		return nil, &NotSingularError{eventdocument.Label}
	}
}

// OnlyX is like Only, but panics if an error occurs.
func (edq *EventDocumentQuery) OnlyX(ctx context.Context) *EventDocument {
	node, err := edq.Only(ctx)
	if err != nil {
		panic(err)
	}
	return node
}

// OnlyID is like Only, but returns the only EventDocument ID in the query.
// Returns a *NotSingularError when more than one EventDocument ID is found.
// Returns a *NotFoundError when no entities are found.
func (edq *EventDocumentQuery) OnlyID(ctx context.Context) (id string, err error) {
	var ids []string
	if ids, err = edq.Limit(2).IDs(setContextOp(ctx, edq.ctx, ent.OpQueryOnlyID)); err != nil {
		return
	}
	switch len(ids) {
	case 1:
		id = ids[0]
	case 0:
		err = &NotFoundError{eventdocument.Label}
	default:
		err = &NotSingularError{eventdocument.Label}
	}
	return
}

// OnlyIDX is like OnlyID, but panics if an error occurs.
func (edq *EventDocumentQuery) OnlyIDX(ctx context.Context) string {
	id, err := edq.OnlyID(ctx)
	if err != nil {
		panic(err)
	}
	return id
}

// All executes the query and returns a list of EventDocuments.
func (edq *EventDocumentQuery) All(ctx context.Context) ([]*EventDocument, error) {
	ctx = setContextOp(ctx, edq.ctx, ent.OpQueryAll)
	if err := edq.prepareQuery(ctx); err != nil {
		return nil, err
	}
	qr := querierAll[[]*EventDocument, *EventDocumentQuery]()
	return withInterceptors[[]*EventDocument](ctx, edq, qr, edq.inters)
}

// AllX is like All, but panics if an error occurs.
func (edq *EventDocumentQuery) AllX(ctx context.Context) []*EventDocument {
	nodes, err := edq.All(ctx)
	if err != nil {
		panic(err)
	}
	return nodes
}

// IDs executes the query and returns a list of EventDocument IDs.
func (edq *EventDocumentQuery) IDs(ctx context.Context) (ids []string, err error) {
	if edq.ctx.Unique == nil && edq.path != nil {
		edq.Unique(true)
	}
	ctx = setContextOp(ctx, edq.ctx, ent.OpQueryIDs)
	if err = edq.Select(eventdocument.FieldID).Scan(ctx, &ids); err != nil {
		return nil, err
	}
	return ids, nil
}

// IDsX is like IDs, but panics if an error occurs.
func (edq *EventDocumentQuery) IDsX(ctx context.Context) []string {
	ids, err := edq.IDs(ctx)
	if err != nil {
		panic(err)
	}
	return ids
}

// Count returns the count of the given query.
func (edq *EventDocumentQuery) Count(ctx context.Context) (int, error) {
	ctx = setContextOp(ctx, edq.ctx, ent.OpQueryCount)
	if err := edq.prepareQuery(ctx); err != nil {
		return 0, err
	}
	return withInterceptors[int](ctx, edq, querierCount[*EventDocumentQuery](), edq.inters)
}

// CountX is like Count, but panics if an error occurs.
func (edq *EventDocumentQuery) CountX(ctx context.Context) int {
	count, err := edq.Count(ctx)
	if err != nil {
		panic(err)
	}
	return count
}

// Exist returns true if the query has elements in the graph.
func (edq *EventDocumentQuery) Exist(ctx context.Context) (bool, error) {
	ctx = setContextOp(ctx, edq.ctx, ent.OpQueryExist)
	switch _, err := edq.FirstID(ctx); {
	case IsNotFound(err):
		return false, nil
	case err != nil:
		return false, fmt.Errorf("ent: check existence: %w", err)
	default:
		return true, nil
	}
}

// ExistX is like Exist, but panics if an error occurs.
func (edq *EventDocumentQuery) ExistX(ctx context.Context) bool {
	exist, err := edq.Exist(ctx)
	if err != nil {
		panic(err)
	}
	return exist
}

// Clone returns a duplicate of the EventDocumentQuery builder, including all associated steps. It can be
// used to prepare common query builders and use them differently after the clone is made.
func (edq *EventDocumentQuery) Clone() *EventDocumentQuery {
	if edq == nil {
		return nil
	}
	return &EventDocumentQuery{
		config:       edq.config,
		ctx:          edq.ctx.Clone(),
		order:        append([]eventdocument.OrderOption{}, edq.order...),
		inters:       append([]Interceptor{}, edq.inters...),
		predicates:   append([]predicate.EventDocument{}, edq.predicates...),
		withDocument: edq.withDocument.Clone(),
		withEvent:    edq.withEvent.Clone(),
		// clone intermediate query.
		sql:  edq.sql.Clone(),
		path: edq.path,
	}
}

// WithDocument tells the query-builder to eager-load the nodes that are connected to
// the "document" edge. The optional arguments are used to configure the query builder of the edge.
func (edq *EventDocumentQuery) WithDocument(opts ...func(*DocumentQuery)) *EventDocumentQuery {
	query := (&DocumentClient{config: edq.config}).Query()
	for _, opt := range opts {
		opt(query)
	}
	edq.withDocument = query
	return edq
}

// WithEvent tells the query-builder to eager-load the nodes that are connected to
// the "event" edge. The optional arguments are used to configure the query builder of the edge.
func (edq *EventDocumentQuery) WithEvent(opts ...func(*EventQuery)) *EventDocumentQuery {
	query := (&EventClient{config: edq.config}).Query()
	for _, opt := range opts {
		opt(query)
	}
	edq.withEvent = query
	return edq
}

// GroupBy is used to group vertices by one or more fields/columns.
// It is often used with aggregate functions, like: count, max, mean, min, sum.
//
// Example:
//
//	var v []struct {
//		Type string `json:"type,omitempty"`
//		Count int `json:"count,omitempty"`
//	}
//
//	client.EventDocument.Query().
//		GroupBy(eventdocument.FieldType).
//		Aggregate(ent.Count()).
//		Scan(ctx, &v)
func (edq *EventDocumentQuery) GroupBy(field string, fields ...string) *EventDocumentGroupBy {
	edq.ctx.Fields = append([]string{field}, fields...)
	grbuild := &EventDocumentGroupBy{build: edq}
	grbuild.flds = &edq.ctx.Fields
	grbuild.label = eventdocument.Label
	grbuild.scan = grbuild.Scan
	return grbuild
}

// Select allows the selection one or more fields/columns for the given query,
// instead of selecting all fields in the entity.
//
// Example:
//
//	var v []struct {
//		Type string `json:"type,omitempty"`
//	}
//
//	client.EventDocument.Query().
//		Select(eventdocument.FieldType).
//		Scan(ctx, &v)
func (edq *EventDocumentQuery) Select(fields ...string) *EventDocumentSelect {
	edq.ctx.Fields = append(edq.ctx.Fields, fields...)
	sbuild := &EventDocumentSelect{EventDocumentQuery: edq}
	sbuild.label = eventdocument.Label
	sbuild.flds, sbuild.scan = &edq.ctx.Fields, sbuild.Scan
	return sbuild
}

// Aggregate returns a EventDocumentSelect configured with the given aggregations.
func (edq *EventDocumentQuery) Aggregate(fns ...AggregateFunc) *EventDocumentSelect {
	return edq.Select().Aggregate(fns...)
}

func (edq *EventDocumentQuery) prepareQuery(ctx context.Context) error {
	for _, inter := range edq.inters {
		if inter == nil {
			return fmt.Errorf("ent: uninitialized interceptor (forgotten import ent/runtime?)")
		}
		if trv, ok := inter.(Traverser); ok {
			if err := trv.Traverse(ctx, edq); err != nil {
				return err
			}
		}
	}
	for _, f := range edq.ctx.Fields {
		if !eventdocument.ValidColumn(f) {
			return &ValidationError{Name: f, err: fmt.Errorf("ent: invalid field %q for query", f)}
		}
	}
	if edq.path != nil {
		prev, err := edq.path(ctx)
		if err != nil {
			return err
		}
		edq.sql = prev
	}
	return nil
}

func (edq *EventDocumentQuery) sqlAll(ctx context.Context, hooks ...queryHook) ([]*EventDocument, error) {
	var (
		nodes       = []*EventDocument{}
		withFKs     = edq.withFKs
		_spec       = edq.querySpec()
		loadedTypes = [2]bool{
			edq.withDocument != nil,
			edq.withEvent != nil,
		}
	)
	if edq.withDocument != nil || edq.withEvent != nil {
		withFKs = true
	}
	if withFKs {
		_spec.Node.Columns = append(_spec.Node.Columns, eventdocument.ForeignKeys...)
	}
	_spec.ScanValues = func(columns []string) ([]any, error) {
		return (*EventDocument).scanValues(nil, columns)
	}
	_spec.Assign = func(columns []string, values []any) error {
		node := &EventDocument{config: edq.config}
		nodes = append(nodes, node)
		node.Edges.loadedTypes = loadedTypes
		return node.assignValues(columns, values)
	}
	for i := range hooks {
		hooks[i](ctx, _spec)
	}
	if err := sqlgraph.QueryNodes(ctx, edq.driver, _spec); err != nil {
		return nil, err
	}
	if len(nodes) == 0 {
		return nodes, nil
	}
	if query := edq.withDocument; query != nil {
		if err := edq.loadDocument(ctx, query, nodes, nil,
			func(n *EventDocument, e *Document) { n.Edges.Document = e }); err != nil {
			return nil, err
		}
	}
	if query := edq.withEvent; query != nil {
		if err := edq.loadEvent(ctx, query, nodes, nil,
			func(n *EventDocument, e *Event) { n.Edges.Event = e }); err != nil {
			return nil, err
		}
	}
	return nodes, nil
}

func (edq *EventDocumentQuery) loadDocument(ctx context.Context, query *DocumentQuery, nodes []*EventDocument, init func(*EventDocument), assign func(*EventDocument, *Document)) error {
	ids := make([]string, 0, len(nodes))
	nodeids := make(map[string][]*EventDocument)
	for i := range nodes {
		if nodes[i].document_event_documents == nil {
			continue
		}
		fk := *nodes[i].document_event_documents
		if _, ok := nodeids[fk]; !ok {
			ids = append(ids, fk)
		}
		nodeids[fk] = append(nodeids[fk], nodes[i])
	}
	if len(ids) == 0 {
		return nil
	}
	query.Where(document.IDIn(ids...))
	neighbors, err := query.All(ctx)
	if err != nil {
		return err
	}
	for _, n := range neighbors {
		nodes, ok := nodeids[n.ID]
		if !ok {
			return fmt.Errorf(`unexpected foreign-key "document_event_documents" returned %v`, n.ID)
		}
		for i := range nodes {
			assign(nodes[i], n)
		}
	}
	return nil
}
func (edq *EventDocumentQuery) loadEvent(ctx context.Context, query *EventQuery, nodes []*EventDocument, init func(*EventDocument), assign func(*EventDocument, *Event)) error {
	ids := make([]string, 0, len(nodes))
	nodeids := make(map[string][]*EventDocument)
	for i := range nodes {
		if nodes[i].event_event_documents == nil {
			continue
		}
		fk := *nodes[i].event_event_documents
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
			return fmt.Errorf(`unexpected foreign-key "event_event_documents" returned %v`, n.ID)
		}
		for i := range nodes {
			assign(nodes[i], n)
		}
	}
	return nil
}

func (edq *EventDocumentQuery) sqlCount(ctx context.Context) (int, error) {
	_spec := edq.querySpec()
	_spec.Node.Columns = edq.ctx.Fields
	if len(edq.ctx.Fields) > 0 {
		_spec.Unique = edq.ctx.Unique != nil && *edq.ctx.Unique
	}
	return sqlgraph.CountNodes(ctx, edq.driver, _spec)
}

func (edq *EventDocumentQuery) querySpec() *sqlgraph.QuerySpec {
	_spec := sqlgraph.NewQuerySpec(eventdocument.Table, eventdocument.Columns, sqlgraph.NewFieldSpec(eventdocument.FieldID, field.TypeString))
	_spec.From = edq.sql
	if unique := edq.ctx.Unique; unique != nil {
		_spec.Unique = *unique
	} else if edq.path != nil {
		_spec.Unique = true
	}
	if fields := edq.ctx.Fields; len(fields) > 0 {
		_spec.Node.Columns = make([]string, 0, len(fields))
		_spec.Node.Columns = append(_spec.Node.Columns, eventdocument.FieldID)
		for i := range fields {
			if fields[i] != eventdocument.FieldID {
				_spec.Node.Columns = append(_spec.Node.Columns, fields[i])
			}
		}
	}
	if ps := edq.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	if limit := edq.ctx.Limit; limit != nil {
		_spec.Limit = *limit
	}
	if offset := edq.ctx.Offset; offset != nil {
		_spec.Offset = *offset
	}
	if ps := edq.order; len(ps) > 0 {
		_spec.Order = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	return _spec
}

func (edq *EventDocumentQuery) sqlQuery(ctx context.Context) *sql.Selector {
	builder := sql.Dialect(edq.driver.Dialect())
	t1 := builder.Table(eventdocument.Table)
	columns := edq.ctx.Fields
	if len(columns) == 0 {
		columns = eventdocument.Columns
	}
	selector := builder.Select(t1.Columns(columns...)...).From(t1)
	if edq.sql != nil {
		selector = edq.sql
		selector.Select(selector.Columns(columns...)...)
	}
	if edq.ctx.Unique != nil && *edq.ctx.Unique {
		selector.Distinct()
	}
	for _, p := range edq.predicates {
		p(selector)
	}
	for _, p := range edq.order {
		p(selector)
	}
	if offset := edq.ctx.Offset; offset != nil {
		// limit is mandatory for offset clause. We start
		// with default value, and override it below if needed.
		selector.Offset(*offset).Limit(math.MaxInt32)
	}
	if limit := edq.ctx.Limit; limit != nil {
		selector.Limit(*limit)
	}
	return selector
}

// EventDocumentGroupBy is the group-by builder for EventDocument entities.
type EventDocumentGroupBy struct {
	selector
	build *EventDocumentQuery
}

// Aggregate adds the given aggregation functions to the group-by query.
func (edgb *EventDocumentGroupBy) Aggregate(fns ...AggregateFunc) *EventDocumentGroupBy {
	edgb.fns = append(edgb.fns, fns...)
	return edgb
}

// Scan applies the selector query and scans the result into the given value.
func (edgb *EventDocumentGroupBy) Scan(ctx context.Context, v any) error {
	ctx = setContextOp(ctx, edgb.build.ctx, ent.OpQueryGroupBy)
	if err := edgb.build.prepareQuery(ctx); err != nil {
		return err
	}
	return scanWithInterceptors[*EventDocumentQuery, *EventDocumentGroupBy](ctx, edgb.build, edgb, edgb.build.inters, v)
}

func (edgb *EventDocumentGroupBy) sqlScan(ctx context.Context, root *EventDocumentQuery, v any) error {
	selector := root.sqlQuery(ctx).Select()
	aggregation := make([]string, 0, len(edgb.fns))
	for _, fn := range edgb.fns {
		aggregation = append(aggregation, fn(selector))
	}
	if len(selector.SelectedColumns()) == 0 {
		columns := make([]string, 0, len(*edgb.flds)+len(edgb.fns))
		for _, f := range *edgb.flds {
			columns = append(columns, selector.C(f))
		}
		columns = append(columns, aggregation...)
		selector.Select(columns...)
	}
	selector.GroupBy(selector.Columns(*edgb.flds...)...)
	if err := selector.Err(); err != nil {
		return err
	}
	rows := &sql.Rows{}
	query, args := selector.Query()
	if err := edgb.build.driver.Query(ctx, query, args, rows); err != nil {
		return err
	}
	defer rows.Close()
	return sql.ScanSlice(rows, v)
}

// EventDocumentSelect is the builder for selecting fields of EventDocument entities.
type EventDocumentSelect struct {
	*EventDocumentQuery
	selector
}

// Aggregate adds the given aggregation functions to the selector query.
func (eds *EventDocumentSelect) Aggregate(fns ...AggregateFunc) *EventDocumentSelect {
	eds.fns = append(eds.fns, fns...)
	return eds
}

// Scan applies the selector query and scans the result into the given value.
func (eds *EventDocumentSelect) Scan(ctx context.Context, v any) error {
	ctx = setContextOp(ctx, eds.ctx, ent.OpQuerySelect)
	if err := eds.prepareQuery(ctx); err != nil {
		return err
	}
	return scanWithInterceptors[*EventDocumentQuery, *EventDocumentSelect](ctx, eds.EventDocumentQuery, eds, eds.inters, v)
}

func (eds *EventDocumentSelect) sqlScan(ctx context.Context, root *EventDocumentQuery, v any) error {
	selector := root.sqlQuery(ctx)
	aggregation := make([]string, 0, len(eds.fns))
	for _, fn := range eds.fns {
		aggregation = append(aggregation, fn(selector))
	}
	switch n := len(*eds.selector.flds); {
	case n == 0 && len(aggregation) > 0:
		selector.Select(aggregation...)
	case n != 0 && len(aggregation) > 0:
		selector.AppendSelect(aggregation...)
	}
	rows := &sql.Rows{}
	query, args := selector.Query()
	if err := eds.driver.Query(ctx, query, args, rows); err != nil {
		return err
	}
	defer rows.Close()
	return sql.ScanSlice(rows, v)
}
