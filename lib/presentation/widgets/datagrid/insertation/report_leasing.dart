// Define a model for the STU data
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class LeasingData {
  LeasingData(
    this.type,
    this.spk,
    this.open,
    this.accept,
    this.reject,
    this.approve,
  );

  final String type;
  final int spk;
  final int open;
  final int accept;
  final int reject;
  final int approve;
}

// DataGridSource implementation for the STU table
class LeasingInsertDataSource extends DataGridSource {
  LeasingInsertDataSource() {
    _stuData = [
      LeasingData('BAF', 0, 0, 0, 0, 0),
      LeasingData('Adira', 0, 0, 0, 0, 0),
      LeasingData('SOF', 0, 0, 0, 0, 0),
    ];
    buildDataGridRows();
  }

  // Method to add a new empty row
  void addEmptyRow() {
    _stuData.add(LeasingData('', 0, 0, 0, 0, 0));
    buildDataGridRows();
    notifyListeners();
  }

  late List<LeasingData> _stuData;
  late List<DataGridRow> _dataGridRows;

  void buildDataGridRows() {
    _dataGridRows = _stuData.map<DataGridRow>((data) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'Leasing', value: data.type),
        DataGridCell<int>(columnName: 'SPK', value: data.spk),
        DataGridCell<int>(columnName: 'Opened', value: data.open),
        DataGridCell<int>(columnName: 'Accepted', value: data.accept),
        DataGridCell<int>(columnName: 'Rejected', value: data.reject),
        DataGridCell<int>(columnName: 'Approval', value: data.approve),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().asMap().entries.map<Widget>((cell) {
        log('Cell key: ${cell.key}');
        log('Cell value: ${cell.value.value}');
        final int index = cell.key;
        final String data = cell.value.value.toString();

        if (index == 0 || index == 5) {
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
