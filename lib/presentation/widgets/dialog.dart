import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sop_mobile/data/models/sales_import.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';

class CustomDialog {
  static Widget viewBriefImage(BuildContext context, String image) {
    return AlertDialog(
      title: Text(
        'Bukti Laporan Pagi',
        style: TextThemes.title2.copyWith(fontSize: 16),
      ),
      content: Image.memory(base64Decode(image), fit: BoxFit.contain),
    );
  }

  static Widget alertSalesImport(
    BuildContext context,
    List<NewSalesModel> list,
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
                children: [
                  Text(list[index].id),
                  Text(list[index].tier),
                  Builder(
                    builder: (context) {
                      if (list[index].isActive == 1) {
                        return const Text('Aktif');
                      } else {
                        return const Text('Tidak Aktif');
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(child: const Text('Import'), onPressed: () => func()),
      ],
    );
  }
}
