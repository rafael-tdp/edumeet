import 'package:flutter/material.dart';

class DataTableWithPagination<T> extends StatefulWidget {
  final List<T> data;
  final List<DataColumn> columns;
  final List<DataCell> Function(T item) rowBuilder;
  final int initialRowsPerPage;

  const DataTableWithPagination({
    Key? key,
    required this.data,
    required this.columns,
    required this.rowBuilder,
    this.initialRowsPerPage = 10,
  }) : super(key: key);

  @override
  _DataTableWithPaginationState<T> createState() =>
      _DataTableWithPaginationState<T>();
}

class _DataTableWithPaginationState<T> extends State<DataTableWithPagination<T>> {
  late int _currentPage;
  late int _rowsPerPage;
  late int _totalPages;

  final List<int> _validRowsPerPageOptions = [5, 10, 15, 20];

  @override
  void initState() {
    super.initState();
    _rowsPerPage = _validRowsPerPageOptions.contains(widget.initialRowsPerPage)
        ? widget.initialRowsPerPage
        : 10;
    _currentPage = 0;
    _totalPages = (widget.data.length / _rowsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    int startIndex = _currentPage * _rowsPerPage;
    int endIndex = (startIndex + _rowsPerPage) > widget.data.length
        ? widget.data.length
        : startIndex + _rowsPerPage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            width: double.infinity,
            child: PaginatedDataTable(
              rowsPerPage: _rowsPerPage,
              availableRowsPerPage: _validRowsPerPageOptions,
              onRowsPerPageChanged: (rowsPerPage) {
                if (rowsPerPage != null && _validRowsPerPageOptions.contains(rowsPerPage)) {
                  setState(() {
                    _rowsPerPage = rowsPerPage;
                    _totalPages = (widget.data.length / _rowsPerPage).ceil();
                  });
                }
              },
              columns: widget.columns,
              source: _DataSource(widget.data, widget.rowBuilder),
              columnSpacing: 20,
              headingRowHeight: 60,
              horizontalMargin: 10,
              showCheckboxColumn: false,
            ),
          ),
        ),
        _buildPagination(),
      ],
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
    );
  }
}

class _DataSource<T> extends DataTableSource {
  final List<T> _data;
  final List<DataCell> Function(T item) rowBuilder;

  _DataSource(this._data, this.rowBuilder);

  @override
  DataRow getRow(int index) {
    if (index >= _data.length) {
      return null!;
    }
    return DataRow(
      cells: rowBuilder(_data[index]),
      color: index.isEven
          ? MaterialStateProperty.all(Colors.grey.shade200)
          : MaterialStateProperty.all(Colors.white),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
