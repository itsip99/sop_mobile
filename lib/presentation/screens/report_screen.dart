import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_stu.dart';
import 'package:sop_mobile/presentation/widgets/textformfield.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController dealerController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController personController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // toolbarHeight: 100,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: true,
        backgroundColor: ConstantColors.primaryColor1,
        title: const Text(
          'Daily Report',
          style: TextThemes.subtitle,
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            if (Platform.isIOS) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 15,
                ),
                onPressed: () => Navigator.pop(context),
              );
            } else {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: 20,
                ),
                onPressed: () => Navigator.pop(context),
              );
            }
          },
        ),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: ConstantColors.primaryColor1,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: ConstantColors.primaryColor2,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Wrap(
            runSpacing: 10,
            children: [
              // ~:Page Title and Description:~
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ~:Title:~
                  Text(
                    'Informasi Laporan',
                    style: TextThemes.subtitle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // ~:Description:~
                  const Text(
                    'Masukkan data untuk membuat laporan harian.',
                    style: TextThemes.normal,
                  ),
                ],
              ),

              // ~:Subdealer Data:~
              Wrap(
                children: [
                  // ~:Dealer Textfield:~
                  CustomTextFormField(
                    'your dealer',
                    'Dealer',
                    const Icon(Icons.house_siding_rounded),
                    dealerController,
                    inputFormatters: [Formatter.normalFormatter],
                  ),

                  // ~:Dealer Textfield:~
                  CustomTextFormField(
                    'your area',
                    'Area',
                    const Icon(Icons.location_pin),
                    areaController,
                    inputFormatters: [Formatter.normalFormatter],
                  ),

                  // ~:Dealer Textfield:~
                  CustomTextFormField(
                    'your PIC name',
                    'PIC',
                    const Icon(Icons.person),
                    personController,
                    inputFormatters: [Formatter.normalFormatter],
                  ),
                ],
              ),

              // ~:STU Input Table:~
              SizedBox(
                height: 300,
                child: SfDataGrid(
                  source: StuInsertDataSource(),
                  allowEditing: true,
                  columnWidthMode: ColumnWidthMode.fill,
                  horizontalScrollPhysics: const NeverScrollableScrollPhysics(),
                  verticalScrollPhysics: const NeverScrollableScrollPhysics(),
                  columns: [
                    GridColumn(
                      columnName: 'Type',
                      label: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Type',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'Result',
                      label: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Result',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'Target',
                      label: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Target',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'Ach',
                      label: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Ach',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'LM',
                      label: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'LM',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'Growth',
                      label: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Growth',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
