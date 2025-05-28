// Define a model for the STU data
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PaymentData {
  PaymentData(this.type, this.result, this.lm, this.growth);

  final String type;
  final int result;
  final int lm;
  final int growth;
}

// DataGridSource implementation for the STU table
class PaymentInsertDataSource extends DataGridSource {
  PaymentInsertDataSource() {
    _stuData = [
      PaymentData('Cash', 0, 0, 0),
      PaymentData('Credit', 0, 0, 0),
    ];
    buildDataGridRows();
  }

  late List<PaymentData> _stuData;
  late List<DataGridRow> _dataGridRows;

  void buildDataGridRows() {
    _dataGridRows = _stuData.map<DataGridRow>((data) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'STU', value: data.type),
        DataGridCell<int>(columnName: 'Result', value: data.result),
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
        log('Cell key: ${cell.key}');
        log('Cell value: ${cell.value.value}');
        final int index = cell.key;
        final String data = cell.value.value.toString();

        if (index == 0 || index == 3) {
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
