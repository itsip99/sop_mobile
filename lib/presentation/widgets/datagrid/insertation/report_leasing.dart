// Define a model for the STU data

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  String type;
  int spk;
  int open;
  int accept;
  int reject;
  double approve;

  // Add a copyWith method for easier immutable updates
  LeasingData copyWith({
    String? type,
    int? spk,
    int? open,
    int? accept,
    int? reject,
    double? approve,
  }) {
    return LeasingData(
      type ?? this.type,
      spk ?? this.spk,
      open ?? this.open,
      accept ?? this.accept,
      reject ?? this.reject,
      approve ?? this.approve,
    );
  }
}

// DataGridSource implementation for the STU table
class LeasingInsertDataSource extends DataGridSource {
  final Function(int rowIndex, String columnName, int newValue)?
      onCellValueEdited;

  LeasingInsertDataSource(List<LeasingData> data, {this.onCellValueEdited}) {
    log('Data Source length: ${data.length}');
    _leasingData = List<LeasingData>.from(data);
    buildDataGridRows();
  }

  // Method to update data and refresh the grid
  void updateData(List<LeasingData> newData) {
    log('Updating data source with ${newData.length} items');
    _leasingData = List<LeasingData>.from(newData);
    buildDataGridRows();
    notifyListeners();
  }

  // Method to add a new empty row
  // void addEmptyRow() {
  //   _stuData.add(LeasingData('JOE', 0, 0, 0, 0, 0));
  //   buildDataGridRows();
  //   notifyListeners();
  // }

  late List<LeasingData> _leasingData;
  late List<DataGridRow> _dataGridRows;

  void buildDataGridRows() {
    _dataGridRows = _leasingData.map<DataGridRow>((data) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'Leasing', value: data.type),
        DataGridCell<int>(columnName: 'SPK', value: data.spk),
        DataGridCell<int>(columnName: 'Opened', value: data.open),
        DataGridCell<int>(columnName: 'Accepted', value: data.accept),
        DataGridCell<int>(columnName: 'Rejected', value: data.reject),
        DataGridCell<double>(columnName: 'Approval', value: data.approve),
      ]);
    }).toList();
    notifyListeners(); // Notify listeners after building rows
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = _dataGridRows.indexOf(row);
    LeasingData leasingEntry = _leasingData[rowIndex];

    return DataGridRowAdapter(
      cells: row.getCells().asMap().entries.map<Widget>((entry) {
        // log('Cell key: ${cell.key}');
        // log('Cell value: ${cell.value.value}');
        final int cellIndex = entry.key;
        final DataGridCell<dynamic> dataGridCell = entry.value;
        final String columnName = dataGridCell.columnName;

        bool isEditable = columnName == 'SPK' ||
            columnName == 'Opened' ||
            columnName == 'Accepted' ||
            columnName == 'Rejected';

        if (isEditable) {
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
              onChanged: (String newValueString) {
                int? parsedValue = int.tryParse(newValueString);
                // You can add logic here to update the underlying data model if needed
                final rowIndex = _dataGridRows.indexOf(row);
                if (rowIndex != -1) {
                  switch (cellIndex) {
                    case 1:
                      _leasingData[rowIndex].spk = parsedValue ?? 0;
                      break;
                    case 2:
                      _leasingData[rowIndex].open = parsedValue ?? 0;
                      break;
                    case 3:
                      _leasingData[rowIndex].accept = parsedValue ?? 0;
                      break;
                    case 4:
                      _leasingData[rowIndex].reject = parsedValue ?? 0;
                      break;
                    case 5:
                      _leasingData[rowIndex].approve =
                          double.tryParse(newValueString) ?? 0;
                      break;
                    default:
                      break;
                  }
                }

                if (parsedValue != null && onCellValueEdited != null) {
                  // Call the callback provided by ReportScreen
                  onCellValueEdited!(rowIndex, columnName, parsedValue);
                }
              },
            ),
          );
        } else if (columnName == 'Approval') {
          // Format the approvalRate (double 0.0-1.0) as a percentage string
          String approvalText = (leasingEntry.approve * 100).toStringAsFixed(1);
          return Center(
            child: Text(
              '$approvalText%',
              textAlign: TextAlign.center,
              style: TextThemes.normal, // (using existing style)
            ),
          );
        } else {
          // 'Leasing' column (Type)
          return Center(
            child: Text(
              dataGridCell.value.toString(),
              textAlign: TextAlign.center,
              style: TextThemes.normal.copyWith(fontWeight: FontWeight.bold), //
            ),
          );
        }
      }).toList(),
    );
  }
}
