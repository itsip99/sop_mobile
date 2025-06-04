import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/presentation/state/leasing/leasing_bloc.dart';
import 'package:sop_mobile/presentation/state/leasing/leasing_event.dart';
import 'package:sop_mobile/presentation/state/leasing/leasing_state.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/data_grid.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_leasing.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_payment.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_stu.dart';
import 'package:sop_mobile/presentation/widgets/textformfield.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController dealerController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController personController = TextEditingController();

  double tableHeight = 260;
  List<LeasingData> leasingData = [];

  void editLeasingValue(
    LeasingBloc leasingBloc,
    int rowIndex,
    String columnName,
    int newValue,
  ) {
    if (columnName == 'Accepted') {
      // 'accept'
      leasingBloc.add(LeasingDataModified(
        rowIndex: rowIndex,
        newAcceptedValue: newValue,
      ));
    } else if (columnName == 'Rejected') {
      // 'reject'
      leasingBloc.add(LeasingDataModified(
        rowIndex: rowIndex,
        newRejectedValue: newValue,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final leasingBloc = context.read<LeasingBloc>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          child: Column(
            spacing: 10,
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
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    spacing: 8,
                    children: [
                      // ~:Textfields:~
                      Column(
                        spacing: 4,
                        children: [
                          // ~:Dealer Textfield:~
                          CustomTextFormField(
                            'your dealer',
                            'Dealer',
                            const Icon(Icons.house_siding_rounded),
                            dealerController,
                            isLabelFloat: true,
                            inputFormatters: [Formatter.normalFormatter],
                            borderRadius: 20,
                          ),

                          // ~:Dealer Textfield:~
                          CustomTextFormField(
                            'your area',
                            'Area',
                            const Icon(Icons.location_pin),
                            areaController,
                            isLabelFloat: true,
                            inputFormatters: [Formatter.normalFormatter],
                            borderRadius: 20,
                          ),

                          // ~:Dealer Textfield:~
                          CustomTextFormField(
                            'your PIC name',
                            'PIC',
                            const Icon(Icons.person),
                            personController,
                            isLabelFloat: true,
                            inputFormatters: [Formatter.normalFormatter],
                            borderRadius: 20,
                          ),
                        ],
                      ),

                      // ~:Input Tables:~
                      Column(
                        spacing: 12,
                        children: [
                          // ~:STU Input Table:~
                          CustomDataGrid.report(
                            context,
                            StuInsertDataSource(),
                            ['STU', 'Result', 'Target', 'Ach', 'LM', 'Growth'],
                            allowEditing: true,
                            horizontalScrollPhysics:
                                const BouncingScrollPhysics(),
                          ),

                          // ~:Payment Input Table:~
                          CustomDataGrid.report(
                            context,
                            PaymentInsertDataSource(),
                            ['Payment', 'Result', 'Target', 'Growth'],
                            tableHeight: 215,
                            allowEditing: true,
                            horizontalScrollPhysics:
                                const BouncingScrollPhysics(),
                          ),

                          // ~:Leasing Input Table:~
                          BlocBuilder<LeasingBloc, LeasingState>(
                            builder: (context, state) {
                              leasingData = state.data;
                              if (state is AddLeasingData) {
                                leasingData = state.newData;
                                log('New Leasing length: ${leasingData.length}');
                                tableHeight =
                                    260 + (50 * (leasingData.length - 3));
                                log('Updated table height: $tableHeight');
                              }

                              log('Leasing length: ${state.data.length}');
                              return CustomDataGrid.report(
                                context,
                                LeasingInsertDataSource(
                                  leasingData,
                                  onCellValueEdited:
                                      (rowIndex, columnName, newValue) {
                                    editLeasingValue(
                                      leasingBloc,
                                      rowIndex,
                                      columnName,
                                      newValue,
                                    );
                                  },
                                ),
                                <String>[
                                  'Leasing',
                                  'SPK',
                                  'Terbuka',
                                  'Disetujui',
                                  'Ditolak',
                                  'Approval',
                                ],
                                tableHeight: tableHeight,
                                allowEditing: true,
                                horizontalScrollPhysics:
                                    const BouncingScrollPhysics(),
                                verticalScrollPhysics:
                                    const AlwaysScrollableScrollPhysics(),
                                enableAddRow: true,
                                addFunction: () async {
                                  log('Add New Row');
                                  leasingBloc.add(LeasingDataAdded());
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // ~:Create Button:~
              ElevatedButton(
                onPressed: () {
                  for (var data in leasingData) {
                    log('Leasing Data: ${data.type}, SPK: ${data.spk}, Opened: ${data.open}, Accepted: ${data.accept}, Rejected: ${data.reject}, Approval: ${data.approve}');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ConstantColors.primaryColor1,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 24,
                  child: const Text(
                    'Buat',
                    style: TextThemes.subtitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
