import 'package:flutter/material.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CustomDataGrid {
  static Widget report(
    final BuildContext context,
    final DataGridSource dataSource,
    final List<String> loadedData, {
    final double tableHeight = 260,
    final bool enableAddRow = false,
    final bool allowEditing = false,
    final double headerRowHeight = 48,
    final double rowHeight = 48,
    final ColumnWidthMode columnWidthMode = ColumnWidthMode.fitByColumnName,
    final ScrollPhysics horizontalScrollPhysics =
        const NeverScrollableScrollPhysics(),
    final ScrollPhysics verticalScrollPhysics =
        const NeverScrollableScrollPhysics(),
    final double rowHeaderWidth = 60,
    final double rowBodyWidth = 60,
    final TextStyle textStyle = TextThemes.normal,
    final Alignment textAlignment = Alignment.center,
    final VoidCallback? addFunction,
    final Key? key,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: tableHeight,
      child: SfDataGrid(
        key: key,
        source: dataSource,
        allowEditing: allowEditing,
        columnWidthMode: columnWidthMode,
        horizontalScrollPhysics: horizontalScrollPhysics,
        verticalScrollPhysics: verticalScrollPhysics,
        // headerRowHeight: headerRowHeight,
        // rowHeight: rowHeight,
        footerHeight: 0.0,
        footer: const SizedBox(),
        stackedHeaderRows: [
          StackedHeaderRow(
            cells: [
              StackedHeaderCell(
                columnNames: loadedData,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (enableAddRow)
                      IconButton(
                        icon: const Icon(Icons.add),
                        tooltip: 'Add Row',
                        onPressed: () async => addFunction!(),
                      ),
                    Text(
                      loadedData[0] != 'stu'
                          ? '${(loadedData[0][0].toUpperCase() + loadedData[0].substring(1))} Report'
                          : '${loadedData[0].toUpperCase()} Report',
                      style: textStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        columns: loadedData.asMap().entries.map((name) {
          final int index = name.key;
          final String data = name.value;

          if (index == 0) {
            return GridColumn(
              columnName: data,
              width: rowHeaderWidth,
              label: Container(
                alignment: textAlignment,
                child: Text(
                  data != 'stu'
                      ? data[0].toUpperCase() + data.substring(1)
                      : data.toUpperCase(),
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          } else {
            return GridColumn(
              columnName: data,
              width: rowBodyWidth,
              label: Container(
                alignment: textAlignment,
                child: Text(
                  data == 'lm' || data == 'spk'
                      ? data.toUpperCase()
                      : data[0].toUpperCase() + data.substring(1),
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
        }).toList(),
      ),
    );
  }
}
