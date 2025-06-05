// Define a model for the STU data

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StuData {
  StuData(this.type, this.result, this.target, this.ach, this.lm, this.growth);

  String type;
  int result;
  int target;
  String ach;
  int lm;
  String growth;

  // Add a copyWith method for easier immutable updates
  StuData copyWith({
    String? type,
    int? result,
    int? target,
    String? ach,
    int? lm,
    String? growth,
  }) {
    return StuData(
      type ?? this.type,
      result ?? this.result,
      target ?? this.target,
      ach ?? this.ach,
      lm ?? this.lm,
      growth ?? this.growth,
    );
  }
}

// DataGridSource implementation for the STU table
class StuInsertDataSource extends DataGridSource {
  final Function(int rowIndex, String columnName, int newValue)?
      onCellValueEdited;

  StuInsertDataSource(List<StuData> data, {this.onCellValueEdited}) {
    // _stuData = [
    //   StuData('MAXI', 0, 0, '0', 0, '0'),
    //   StuData('AT CLASSY', 0, 0, '0', 0, '0'),
    //   StuData('AT LPM', 0, 0, '0', 0, '0'),
    // ];
    _stuData = data;
    buildDataGridRows();
    notifyListeners();
  }

  late List<StuData> _stuData;
  late List<DataGridRow> _dataGridRows;

  void buildDataGridRows() {
    _dataGridRows = _stuData.map<DataGridRow>((data) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'STU', value: data.type),
        DataGridCell<int>(columnName: 'Result', value: data.result),
        DataGridCell<int>(columnName: 'Target', value: data.target),
        DataGridCell<String>(columnName: 'Ach', value: data.ach),
        DataGridCell<int>(columnName: 'LM', value: data.lm),
        DataGridCell<String>(columnName: 'Growth', value: data.growth),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = _dataGridRows.indexOf(row);
    StuData stuEntry = _stuData[rowIndex];

    return DataGridRowAdapter(
      cells: row.getCells().asMap().entries.map<Widget>((entry) {
        // log('Cell key: ${cell.key}');
        // log('Cell value: ${cell.value.value}');
        final int cellIndex = entry.key;
        final DataGridCell<dynamic> dataGridCell = entry.value;
        final String columnName = dataGridCell.columnName;

        bool isEditable = columnName == 'Result' ||
            columnName == 'Target' ||
            columnName == 'LM';

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
              onChanged: (String newValue) {
                int? parsedValue = int.tryParse(newValue);
                // You can add logic here to update the underlying data model if needed
                final rowIndex = _dataGridRows.indexOf(row);
                if (rowIndex != -1) {
                  switch (cellIndex) {
                    case 1:
                      _stuData[rowIndex].result = parsedValue ?? 0;
                      break;
                    case 2:
                      _stuData[rowIndex].target = parsedValue ?? 0;
                      break;
                    case 3:
                      _stuData[rowIndex].lm = parsedValue ?? 0;
                      break;
                    case 4:
                      _stuData[rowIndex].growth = newValue;
                      break;
                    default:
                      break;
                  }
                }

                if (parsedValue != null && onCellValueEdited != null) {
                  onCellValueEdited!(rowIndex, columnName, parsedValue);
                }
              },
            ),
          );
        } else if (columnName == 'Ach' || columnName == 'Growth') {
          // Format the approvalRate (double 0.0-1.0) as a percentage string
          String growthText = stuEntry.growth;
          return Center(
            child: Text(
              '$growthText%',
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
