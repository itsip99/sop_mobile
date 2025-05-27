// Define a model for the STU data
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StuData {
  StuData(this.type, this.result, this.target, this.ach, this.lm, this.growth);

  final String type;
  final int result;
  final int target;
  final double ach;
  final int lm;
  final double growth;
}

// DataGridSource implementation for the STU table
class StuInsertDataSource extends DataGridSource {
  StuInsertDataSource() {
    _stuData = [
      StuData('Type 1', 0, 0, 0.0, 0, 0.0),
      StuData('Type 2', 0, 0, 0.0, 0, 0.0),
      StuData('Type 3', 0, 0, 0.0, 0, 0.0),
    ];
    buildDataGridRows();
  }

  late List<StuData> _stuData;
  late List<DataGridRow> _dataGridRows;

  void buildDataGridRows() {
    _dataGridRows = _stuData.map<DataGridRow>((data) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'Type', value: data.type),
        DataGridCell<int>(columnName: 'Result', value: data.result),
        DataGridCell<int>(columnName: 'Target', value: data.target),
        DataGridCell<double>(columnName: 'Ach', value: data.ach),
        DataGridCell<int>(columnName: 'LM', value: data.lm),
        DataGridCell<double>(columnName: 'Growth', value: data.growth),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextFormField(
            initialValue: cell.value.toString(),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
            onChanged: (value) {
              // You can add logic here to update the underlying data model if needed
            },
          ),
        );
      }).toList(),
    );
  }
}
