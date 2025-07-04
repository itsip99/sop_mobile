import 'package:flutter/material.dart';
import 'package:sop_mobile/data/models/sales_import.dart';

class CustomDialog {
  static Widget alertSalesImport(
    BuildContext context,
    List<SalesImportModel> list,
    Function func,
  ) {
    return AlertDialog(
      title: const Text('Hasil Import'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: double.maxFinite,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(list[index].name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(list[index].id), Text(list[index].tier)],
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(child: const Text('Import'), onPressed: () => func()),
      ],
    );
  }
}
