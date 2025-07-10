// Define a model for the STU data

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:equatable/equatable.dart';

class PaymentData extends Equatable {
  const PaymentData(this.type, this.result, this.lm, this.growth);

  final String type;
  final int result;
  final int lm;
  final String growth;

  // Add a copyWith method for easier immutable updates
  PaymentData copyWith({String? type, int? result, int? lm, String? growth}) {
    return PaymentData(
      type ?? this.type,
      result ?? this.result,
      lm ?? this.lm,
      growth ?? this.growth,
    );
  }

  @override
  List<Object?> get props => [type, result, lm, growth];
}

// DataGridSource implementation for the STU table
class PaymentInsertDataSource extends DataGridSource {
  final Function(int rowIndex, String columnName, int newValue)?
  onCellValueEdited;
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, FocusNode> _focusNodes = {};

  PaymentInsertDataSource(List<PaymentData> data, {this.onCellValueEdited}) {
    _paymentData = data;
    buildDataGridRows();
    notifyListeners();
  }

  late List<PaymentData> _paymentData;
  late List<DataGridRow> _dataGridRows;

  @override
  void dispose() {
    // Clean up all controllers and focus nodes
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes.values) {
      focusNode.dispose();
    }
    super.dispose();
  }

  String _getControllerKey(int rowIndex, int cellIndex) {
    return '${rowIndex}_$cellIndex';
  }

  void buildDataGridRows() {
    _dataGridRows =
        _paymentData.map<DataGridRow>((data) {
          return DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'STU', value: data.type),
              DataGridCell<int>(columnName: 'Result', value: data.result),
              DataGridCell<int>(columnName: 'LM', value: data.lm),
              DataGridCell<String>(columnName: 'Growth', value: data.growth),
            ],
          );
        }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = _dataGridRows.indexOf(row);
    if (rowIndex == -1) return const DataGridRowAdapter(cells: []);

    PaymentData paymentEntry = _paymentData[rowIndex];

    return DataGridRowAdapter(
      cells:
          row.getCells().asMap().entries.map<Widget>((entry) {
            final int cellIndex = entry.key;
            final DataGridCell<dynamic> dataGridCell = entry.value;
            final String columnName = dataGridCell.columnName;

            bool isEditable = columnName == 'Result' || columnName == 'LM';

            if (isEditable) {
              // Create or get controller and focus node for this cell
              final controllerKey = _getControllerKey(rowIndex, cellIndex);
              final controller =
                  _controllers[controllerKey] ??
                  TextEditingController(text: dataGridCell.value.toString());
              final focusNode = _focusNodes[controllerKey] ?? FocusNode();

              // Store them if they're new
              if (!_controllers.containsKey(controllerKey)) {
                _controllers[controllerKey] = controller;
                _focusNodes[controllerKey] = focusNode;

                // Set up focus listener to select all text when focused
                focusNode.addListener(() {
                  if (focusNode.hasFocus) {
                    controller.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: controller.text.length,
                    );
                  }
                });
              } else {
                // Update controller value if it already exists
                controller.text = dataGridCell.value.toString();
              }

              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: TextFormField(
                  controller: controller,
                  focusNode: focusNode,
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
                    final rowIndex = _dataGridRows.indexOf(row);
                    if (rowIndex != -1) {
                      PaymentData oldData = _paymentData[rowIndex];
                      PaymentData newData;
                      switch (cellIndex) {
                        case 1:
                          newData = oldData.copyWith(result: parsedValue ?? 0);
                          break;
                        case 2:
                          newData = oldData.copyWith(lm: parsedValue ?? 0);
                          break;
                        default:
                          newData =
                              oldData; // Should not happen for editable cells
                          break;
                      }
                      _paymentData[rowIndex] = newData;
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
                  style: TextThemes.normal.copyWith(
                    fontWeight: FontWeight.bold,
                  ), //
                ),
              );
            }
          }).toList(),
    );
  }
}
