// Define a model for the STU data

import 'package:flutter/material.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StuData {
  StuData(this.type, this.result, this.target, this.ach, this.lm, this.growth);

  final String type;
  final int result;
  final int target;
  final int ach;
  final int lm;
  final int growth;
}

// DataGridSource implementation for the STU table
class StuInsertDataSource extends DataGridSource {
  StuInsertDataSource() {
    _stuData = [
      StuData('MAXI', 0, 0, 0, 0, 0),
      StuData('AT CLASSY', 0, 0, 0, 0, 0),
      StuData('AT LPM', 0, 0, 0, 0, 0),
    ];
    buildDataGridRows();
  }

  late List<StuData> _stuData;
  late List<DataGridRow> _dataGridRows;

  void buildDataGridRows() {
    _dataGridRows = _stuData.map<DataGridRow>((data) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'STU', value: data.type),
        DataGridCell<int>(columnName: 'Result', value: data.result),
        DataGridCell<int>(columnName: 'Target', value: data.target),
        DataGridCell<int>(columnName: 'Ach', value: data.ach),
        DataGridCell<int>(columnName: 'LM', value: data.lm),
        DataGridCell<int>(columnName: 'Growth', value: data.growth),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().asMap().entries.map<Widget>((cell) {
        // log('Cell key: ${cell.key}');
        // log('Cell value: ${cell.value.value}');
        final int index = cell.key;
        final String data = cell.value.value.toString();

        if (index == 0 || index == 3 || index == 5) {
          return Center(
            child: Text(
              data,
              textAlign: TextAlign.center,
              style: (index == 0)
                  ? TextThemes.normal.copyWith(fontWeight: FontWeight.bold)
                  : TextThemes.normal,
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              initialValue: cell.value.value.toString(),
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
              onChanged: (value) {
                // You can add logic here to update the underlying data model if needed
              },
            ),
          );
        }
      }).toList(),
    );
  }
}
