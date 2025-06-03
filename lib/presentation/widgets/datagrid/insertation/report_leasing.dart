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

  String type;
  int spk;
  int open;
  int accept;
  int reject;
  int approve;
}

// DataGridSource implementation for the STU table
class LeasingInsertDataSource extends DataGridSource {
  LeasingInsertDataSource(List<LeasingData> data) {
    // _stuData = [
    //   LeasingData('BAF', 0, 0, 0, 0, 0),
    //   LeasingData('Adira', 0, 0, 0, 0, 0),
    //   LeasingData('SOF', 0, 0, 0, 0, 0),
    // ];
    log('Data Source length: ${data.length}');
    _stuData = data;
    buildDataGridRows();
    notifyListeners();
  }

  // Method to add a new empty row
  // void addEmptyRow() {
  //   _stuData.add(LeasingData('JOE', 0, 0, 0, 0, 0));
  //   buildDataGridRows();
  //   notifyListeners();
  // }

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
        // log('Cell key: ${cell.key}');
        // log('Cell value: ${cell.value.value}');
        int index = cell.key;
        String data = cell.value.value.toString();

        if ((index == 0 &&
                (data == 'BAF' || data == 'Adira' || data == 'SOF')) ||
            index == 5) {
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
              keyboardType:
                  index == 0 ? TextInputType.text : TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
              onChanged: (value) {
                // You can add logic here to update the underlying data model if needed
                final rowIndex = _dataGridRows.indexOf(row);
                if (rowIndex != -1) {
                  switch (index) {
                    case 1:
                      _stuData[rowIndex].spk = int.tryParse(value) ?? 0;
                      break;
                    case 2:
                      _stuData[rowIndex].open = int.tryParse(value) ?? 0;
                      break;
                    case 3:
                      _stuData[rowIndex].accept = int.tryParse(value) ?? 0;
                      break;
                    case 4:
                      _stuData[rowIndex].reject = int.tryParse(value) ?? 0;
                      break;
                    case 5:
                      _stuData[rowIndex].approve = int.tryParse(value) ?? 0;
                      break;
                    default:
                      break;
                  }
                  buildDataGridRows();
                  notifyListeners();
                }
                // if (index == 1) {
                //   _stuData[row.getCells()[index].value].spk =
                //       int.tryParse(value) ?? 0;
                // } else if (index == 2) {
                //   _stuData[row.getCells()[index].value].open =
                //       int.tryParse(value) ?? 0;
                // } else if (index == 3) {
                //   _stuData[row.getCells()[index].value].accept =
                //       int.tryParse(value) ?? 0;
                // } else if (index == 4) {
                //   _stuData[row.getCells()[index].value].reject =
                //       int.tryParse(value) ?? 0;
                // } else if (index == 5) {
                //   _stuData[row.getCells()[index].value].approve =
                //       int.tryParse(value) ?? 0;
                // }
              },
            ),
          );
        }
      }).toList(),
    );
  }
}
