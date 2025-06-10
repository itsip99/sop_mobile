import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SalesmanData {
  SalesmanData(
    this.name,
    this.status,
    this.spk,
    this.stu,
    this.stuLm,
  );

  String name;
  String status;
  double spk;
  double stu;
  double stuLm;

  // Add a copyWith method for easier immutable updates
  SalesmanData copyWith({
    String? name,
    String? status,
    double? spk,
    double? stu,
    double? stuLm,
  }) {
    return SalesmanData(
      name ?? this.name,
      status ?? this.status,
      spk ?? this.spk,
      stu ?? this.stu,
      stuLm ?? this.stuLm,
    );
  }
}

class SalesmanInsertDataSource extends DataGridSource {
  final Function(int rowIndex, String columnName, int newValue)?
      onCellValueEdited;

  SalesmanInsertDataSource(List<SalesmanData> data, {this.onCellValueEdited}) {
    _salesmanData = data;
    buildDataGridRows();
    notifyListeners();
  }

  List<SalesmanData> _salesmanData = [];
  List<DataGridRow> _dataGridRows = [];

  @override
  List<DataGridRow> get rows => _dataGridRows;

  void buildDataGridRows() {
    _dataGridRows = _salesmanData.map<DataGridRow>((SalesmanData salesman) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'Nama', value: salesman.name),
        DataGridCell<String>(columnName: 'Status', value: salesman.status),
        DataGridCell<double>(columnName: 'SPK', value: salesman.spk),
        DataGridCell<double>(columnName: 'STU', value: salesman.stu),
        DataGridCell<double>(columnName: 'STU LM', value: salesman.stuLm),
      ]);
    }).toList();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((DataGridCell cell) {
        if (cell.value is double) {
          return Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              cell.value.toStringAsFixed(2),
              style: const TextStyle(fontSize: 14),
            ),
          );
        } else {
          String text =
              cell.value.toString()[0] + cell.value.toString().substring(1);
          return Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          );
        }
      }).toList(),
    );
  }
}
