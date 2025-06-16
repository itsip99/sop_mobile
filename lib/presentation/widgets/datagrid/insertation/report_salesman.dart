import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  int spk;
  int stu;
  int stuLm;

  // Add a copyWith method for easier immutable updates
  SalesmanData copyWith({
    String? name,
    String? status,
    int? spk,
    int? stu,
    int? stuLm,
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
  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRows() {
    dataGridRows.clear();
    dataGridRows.addAll(_salesmanData.map<DataGridRow>((SalesmanData salesman) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'Nama', value: salesman.name),
        DataGridCell<String>(columnName: 'Status', value: salesman.status),
        DataGridCell<int>(columnName: 'SPK', value: salesman.spk),
        DataGridCell<int>(columnName: 'STU', value: salesman.stu),
        DataGridCell<int>(columnName: 'STU LM', value: salesman.stuLm),
      ]);
    }));

    log('DataGridRows built: ${dataGridRows.length} rows');
    // Only log in debug mode to avoid performance issues
    assert(() {
      for (var row in dataGridRows) {
        for (var cell in row.getCells()) {
          log('Cell - Column: ${cell.columnName}, Value: ${cell.value}');
        }
      }
      return true;
    }());
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    log('Row length: ${row.getCells().length}');
    return DataGridRowAdapter(
      cells: row.getCells().asMap().entries.map<Widget>((entry) {
        // final int cellIndex = entry.key;
        final DataGridCell<dynamic> dataGridCell = entry.value;
        final String columnName = dataGridCell.columnName;
        // dynamic data = entry.value.value;
        log('Column: $columnName, Value: ${dataGridCell.value.toString()}');

        if (dataGridCell.value is int) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: TextFormField(
              initialValue: dataGridCell.value.toString(),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
              onChanged: (String newValue) {
                int? parsedValue = int.tryParse(newValue);
                // You can add logic here to update the underlying data model if needed
                final rowIndex = dataGridRows.indexOf(row);
                // log('Row index: $rowIndex, Column: $columnName, New Value: $parsedValue');
                if (newValue.isEmpty) parsedValue = 0;

                if (parsedValue != null && onCellValueEdited != null) {
                  onCellValueEdited!(rowIndex, columnName, parsedValue);
                }
              },
            ),
          );
        } else {
          String temp = dataGridCell.value.toString().toLowerCase();
          String displayText = temp.split(' ').map((word) {
            // if (word.isEmpty) return ' ';
            return word[0].toUpperCase() + word.substring(1);
          }).join(' ');

          return Align(
            alignment: Alignment.center,
            child: Text(
              displayText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          );
        }
      }).toList(),
    );
  }
}
