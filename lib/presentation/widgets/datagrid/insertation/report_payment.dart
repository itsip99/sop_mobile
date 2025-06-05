// Define a model for the STU data

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PaymentData {
  PaymentData(this.type, this.result, this.lm, this.growth);

  String type;
  int result;
  int lm;
  String growth;

  // Add a copyWith method for easier immutable updates
  PaymentData copyWith({
    String? type,
    int? result,
    int? lm,
    String? growth,
  }) {
    return PaymentData(
      type ?? this.type,
      result ?? this.result,
      lm ?? this.lm,
      growth ?? this.growth,
    );
  }
}

// DataGridSource implementation for the STU table
class PaymentInsertDataSource extends DataGridSource {
  final Function(int rowIndex, String columnName, int newValue)?
      onCellValueEdited;

  PaymentInsertDataSource(List<PaymentData> data, {this.onCellValueEdited}) {
    // _paymentData = [
    //   PaymentData('Cash', 0, 0, 0),
    //   PaymentData('Credit', 0, 0, 0),
    // ];
    _paymentData = data;
    buildDataGridRows();
    notifyListeners();
  }

  late List<PaymentData> _paymentData;
  late List<DataGridRow> _dataGridRows;

  void buildDataGridRows() {
    _dataGridRows = _paymentData.map<DataGridRow>((data) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'STU', value: data.type),
        DataGridCell<int>(columnName: 'Result', value: data.result),
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
    PaymentData paymentEntry = _paymentData[rowIndex];

    return DataGridRowAdapter(
      cells: row.getCells().asMap().entries.map<Widget>((entry) {
        // log('Cell key: ${cell.key}');
        // log('Cell value: ${cell.value.value}');
        final int cellIndex = entry.key;
        final DataGridCell<dynamic> dataGridCell = entry.value;
        final String columnName = dataGridCell.columnName;

        bool isEditable = columnName == 'Result' || columnName == 'LM';

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
                      _paymentData[rowIndex].result = parsedValue ?? 0;
                      break;
                    case 2:
                      _paymentData[rowIndex].lm = parsedValue ?? 0;
                      break;
                    case 3:
                      _paymentData[rowIndex].growth = newValue;
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
        } else if (columnName == 'Growth') {
          // Format the approvalRate (double 0.0-1.0) as a percentage string
          String growthText = paymentEntry.growth;
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
