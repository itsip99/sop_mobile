import 'package:flutter/material.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CustomDataGrid {
  static Widget report(
    final DataGridSource dataSource,
    final List<String> loadedData, {
    final bool enableAddRow = false,
    final bool allowEditing = false,
    final ColumnWidthMode columnWidthMode = ColumnWidthMode.fill,
    final ScrollPhysics horizontalScrollPhysics =
        const NeverScrollableScrollPhysics(),
    final ScrollPhysics verticalScrollPhysics =
        const NeverScrollableScrollPhysics(),
    final double rowHeaderWidth = 60,
    final double rowBodyWidth = 60,
    final TextStyle textStyle = TextThemes.normal,
    final Alignment textAlignment = Alignment.center,
    final VoidCallback? addFunction,
  }) {
    return SfDataGrid(
      source: dataSource,
      allowEditing: allowEditing,
      columnWidthMode: columnWidthMode,
      horizontalScrollPhysics: horizontalScrollPhysics,
      verticalScrollPhysics: verticalScrollPhysics,
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
                    '${loadedData[0]} Report',
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
                data,
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
                data,
                style: textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
      }).toList(),
    );
  }
}
