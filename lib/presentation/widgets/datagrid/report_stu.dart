import 'package:flutter/material.dart';
import 'package:sop_mobile/data/models/report.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class StuDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  StuDataSource({required List<StuModel> stuData}) {
    print('STU Data Source: ${stuData.length}');
    _stuData = stuData.map<DataGridRow>((data) {
      final stuData = DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'header',
            value: data.group,
          ),
          DataGridCell<String>(
            columnName: 'result',
            value: data.stuResult.toString(),
          ),
        ],
      );

      return stuData;
    }).toList();
  }

  List<DataGridRow> _stuData = [];

  @override
  List<DataGridRow> get rows => _stuData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    int index = _stuData.indexOf(row);

    return DataGridRowAdapter(
      color: index % 2 == 0 ? Colors.grey[200] : Colors.white,
      cells: row.getCells().map<Widget>((e) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            e.value.toString(),
            style: TextThemes.normal,
          ),
        );
      }).toList(),
    );
  }
}
