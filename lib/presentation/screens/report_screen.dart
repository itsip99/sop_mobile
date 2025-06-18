import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/core/constant/enum.dart';
import 'package:sop_mobile/core/constant/variables.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/data/models/sales.dart';
import 'package:sop_mobile/presentation/state/leasing/leasing_bloc.dart';
import 'package:sop_mobile/presentation/state/leasing/leasing_event.dart';
import 'package:sop_mobile/presentation/state/leasing/leasing_state.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';
import 'package:sop_mobile/presentation/state/payment/payment_bloc.dart';
import 'package:sop_mobile/presentation/state/payment/payment_event.dart';
import 'package:sop_mobile/presentation/state/payment/payment_state.dart';
import 'package:sop_mobile/presentation/state/report/report_bloc.dart';
import 'package:sop_mobile/presentation/state/report/report_event.dart';
import 'package:sop_mobile/presentation/state/report/report_state.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_bloc.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_event.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_state.dart';
import 'package:sop_mobile/presentation/state/stu/stu_bloc.dart';
import 'package:sop_mobile/presentation/state/stu/stu_event.dart';
import 'package:sop_mobile/presentation/state/stu/stu_state.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/buttons.dart';
import 'package:sop_mobile/presentation/widgets/data_grid.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_leasing.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_payment.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_salesman.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_stu.dart';
import 'package:sop_mobile/presentation/widgets/loading.dart';
import 'package:sop_mobile/presentation/widgets/snackbar.dart';
import 'package:sop_mobile/presentation/widgets/textformfield.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController areaController = TextEditingController();

  String _getCityNameFromBranchCode(String branchCode) {
    const branchAreaType = StaticVariables.branchAreaType;
    return branchAreaType[branchCode] ?? branchCode;
  }

  final TextEditingController personController = TextEditingController();

  double tableHeight = 260;
  List<StuData> stuData = [];
  List<PaymentData> paymentData = [];
  List<LeasingData> leasingData = [];
  List<SalesmanData> salesmanData = [];
  List<SalesModel> salesData = [];

  void editStuValue(
    StuBloc stuBloc,
    int rowIndex,
    String columnName,
    int newValue,
  ) {
    if (columnName == 'Result') {
      stuBloc.add(ModifyStuData(
        rowIndex: rowIndex,
        newResultValue: newValue,
      ));
    } else if (columnName == 'Target') {
      stuBloc.add(ModifyStuData(
        rowIndex: rowIndex,
        newTargetValue: newValue,
      ));
    } else if (columnName == 'LM') {
      stuBloc.add(ModifyStuData(
        rowIndex: rowIndex,
        newLmValue: newValue,
      ));
    }
  }

  void editPaymentValue(
    PaymentBloc paymentBloc,
    int rowIndex,
    String columnName,
    int newValue,
  ) {
    if (columnName == 'Result') {
      paymentBloc.add(PaymentDataModified(
        rowIndex: rowIndex,
        newResultValue: newValue,
      ));
    } else if (columnName == 'LM') {
      paymentBloc.add(PaymentDataModified(
        rowIndex: rowIndex,
        newTargetValue: newValue,
      ));
    }
  }

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

  Future<void> editSalesmanValue(
    SalesmanBloc salesmanBloc,
    int rowIndex,
    String columnName,
    int newValue,
  ) async {
    log('Editing salesman at row $rowIndex, column $columnName: $newValue');
    // Add validation for row index
    if (rowIndex < 0) {
      log('Invalid row index: $rowIndex');
      return;
    }
    log('Row index: $rowIndex');
    log('New value: $newValue');
    if (columnName == 'SPK') {
      // 'SPK'
      salesmanBloc.add(ModifySalesman(
        rowIndex: rowIndex,
        newSpkValue: newValue,
      ));
    } else if (columnName == 'STU') {
      // 'STU'
      salesmanBloc.add(ModifySalesman(
        rowIndex: rowIndex,
        newStuValue: newValue,
      ));
    } else if (columnName == 'STU LM') {
      // 'STU LM'
      salesmanBloc.add(ModifySalesman(
        rowIndex: rowIndex,
        newLmValue: newValue,
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
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is LoginSuccess) {
                                // ~:Set the dealer controller text:~
                                if (locationController.text.isEmpty) {
                                  locationController.text =
                                      state.getUserCreds.name;
                                }
                              }

                              return CustomTextFormField(
                                'your location',
                                'Location',
                                const Icon(Icons.garage_rounded),
                                locationController,
                                inputFormatters: [Formatter.normalFormatter],
                                borderRadius: 20,
                                isEnabled: false,
                              );
                            },
                          ),

                          // ~:Area Textfield:~
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is LoginSuccess) {
                                // ~:Set the area controller text:~
                                if (areaController.text.isEmpty) {
                                  areaController.text =
                                      '${state.getUserCreds.branch} ${_getCityNameFromBranchCode(state.getUserCreds.branch)}';
                                }
                              }

                              return CustomTextFormField(
                                'your area',
                                'Area',
                                const Icon(Icons.location_pin),
                                areaController,
                                isLabelFloat: true,
                                inputFormatters: [Formatter.normalFormatter],
                                borderRadius: 20,
                                isEnabled: false,
                              );
                            },
                          ),

                          // ~:PIC Textfield:~
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
                          BlocBuilder<StuBloc, StuState>(
                            builder: (context, state) {
                              stuData = state.data;
                              if (state is StuDataModified) {
                                stuData = state.newData;
                              }

                              return CustomDataGrid.report(
                                context,
                                StuInsertDataSource(
                                  stuData,
                                  onCellValueEdited:
                                      (rowIndex, columnName, newValue) =>
                                          editStuValue(
                                    context.read<StuBloc>(),
                                    rowIndex,
                                    columnName,
                                    newValue,
                                  ),
                                ),
                                StuType.values
                                    .map((e) => e.name.toString())
                                    .toList(),
                                allowEditing: true,
                                horizontalScrollPhysics:
                                    const BouncingScrollPhysics(),
                              );
                            },
                          ),

                          // ~:Payment Input Table:~
                          BlocBuilder<PaymentBloc, PaymentState>(
                            builder: (context, state) {
                              paymentData = state.data;
                              if (state is PaymentModified) {
                                paymentData = state.newData;
                                // log('New Payment length: ${paymentData.length}');
                              }

                              return CustomDataGrid.report(
                                context,
                                PaymentInsertDataSource(
                                  paymentData,
                                  onCellValueEdited:
                                      (rowIndex, columnName, newValue) =>
                                          editPaymentValue(
                                    context.read<PaymentBloc>(),
                                    rowIndex,
                                    columnName,
                                    newValue,
                                  ),
                                ),
                                PaymentType.values
                                    .map((e) => e.name.toString())
                                    .toList(),
                                tableHeight: 215,
                                allowEditing: true,
                                horizontalScrollPhysics:
                                    const BouncingScrollPhysics(),
                              );
                            },
                          ),

                          // ~:Leasing Input Table:~
                          BlocBuilder<LeasingBloc, LeasingState>(
                            builder: (context, state) {
                              tableHeight = 260;
                              leasingData = state.data;
                              if (state is AddLeasingData) {
                                leasingData = state.newData;
                                tableHeight =
                                    260 + (50 * (leasingData.length - 3));
                                // log('Updated table height: $tableHeight');
                              }

                              log('Leasing length: ${state.data.length}');
                              return CustomDataGrid.report(
                                context,
                                LeasingInsertDataSource(
                                  leasingData,
                                  onCellValueEdited:
                                      (rowIndex, columnName, newValue) =>
                                          editLeasingValue(
                                    leasingBloc,
                                    rowIndex,
                                    columnName,
                                    newValue,
                                  ),
                                ),
                                LeasingType.values
                                    .map((e) => e.name.toString())
                                    .toList(),
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

                          // ~:Salesman Input Table:~
                          BlocBuilder<SalesmanBloc, SalesmanState>(
                            builder: (context, state) {
                              tableHeight = 260;
                              salesmanData = state.salesDataList;
                              salesData = state.fetchSalesList;
                              if (state is SalesmanLoading) {
                                return Loading.platformIndicator(
                                  iosRadius: 13,
                                  iosCircleColor: ConstantColors.primaryColor3,
                                  androidWidth: 28,
                                  androidHeight: 28,
                                  androidStrokeWidth: 3.5,
                                  androidCircleColor:
                                      ConstantColors.primaryColor3,
                                );
                              } else if (state is SalesmanFetched) {
                                salesmanData = state.salesDataList;
                              } else if (state is SalesmanModified) {
                                salesmanData = state.newData;
                              }
                              log('Salesman length: ${salesmanData.length}');

                              // ~:Set a dynamic table height:~
                              if (salesmanData.length <= 6) {
                                tableHeight =
                                    260 + (50 * (salesmanData.length - 3));
                              }

                              return CustomDataGrid.report(
                                context,
                                SalesmanInsertDataSource(
                                  salesmanData,
                                  onCellValueEdited:
                                      (rowIndex, columnName, newValue) =>
                                          editSalesmanValue(
                                    context.read<SalesmanBloc>(),
                                    rowIndex,
                                    columnName,
                                    newValue,
                                  ),
                                ),
                                SalesmanType.values
                                    .map((e) => e.name.toString())
                                    .toList(),
                                tableHeight: tableHeight,
                                rowHeaderWidth: 75,
                                allowEditing: true,
                                horizontalScrollPhysics:
                                    const BouncingScrollPhysics(),
                                verticalScrollPhysics:
                                    const AlwaysScrollableScrollPhysics(),
                                columnWidthMode: ColumnWidthMode.fitByCellValue,
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
              BlocConsumer<ReportBloc, ReportState>(
                listener: (context, state) {
                  if (state is ReportCreationSuccess) {
                    log('Report created successfully');
                    CustomSnackbar.showSnackbar(
                      context,
                      'Laporan berhasil dibuat!',
                    );
                    Navigator.pop(context);
                  } else if (state is ReportCreationWarning ||
                      state is ReportCreationError) {
                    log('Report creation warning / error: ${state.message}');
                    CustomSnackbar.showSnackbar(
                      context,
                      state.message,
                    );
                  }
                },
                builder: (context, state) {
                  return CustomButton.primaryButton2(
                    context: context,
                    text: 'Buat',
                    func: () {
                      // log('Dealer: ${locationController.text}');
                      // log('Area: ${areaController.text.split(' ')[1]}');
                      // log('PIC: ${personController.text}');
                      // log('');
                      //
                      // log('STU Data length (screen): ${stuData.length}');
                      // for (var data in stuData) {
                      //   log('STU Data: ${data.type}, Result: ${data.result}, Target: ${data.target}, Ach: ${data.ach}, LM: ${data.lm}, Growth: ${data.growth}');
                      // }
                      // log('');
                      //
                      // for (var data in paymentData) {
                      //   log('Payment Data: ${data.type}, Result: ${data.result}, Target: ${data.lm}, Growth: ${data.growth}%');
                      // }
                      // log('');
                      //
                      // for (var data in leasingData) {
                      //   log('Leasing Data: ${data.type}, SPK: ${data.spk}, Opened: ${data.open}, Accepted: ${data.accept}, Rejected: ${data.reject}, Approval: ${data.approve}');
                      // }
                      // log('');
                      //
                      // for (var data in salesmanData) {
                      //   log('Salesman Data: ${data.name}, Status: ${data.status}, SPK: ${data.spk}, STU: ${data.stu}, STU LM: ${data.stuLm}');
                      // }

                      context.read<ReportBloc>().add(
                            CreateReport(
                              dealerName: locationController.text,
                              areaName: areaController.text.split(' ')[0],
                              personInCharge: personController.text,
                              stuData: stuData,
                              paymentData: paymentData,
                              leasingData: leasingData,
                              salesmanData: salesmanData,
                              salesData: salesData,
                            ),
                          );
                    },
                    bgColor: ConstantColors.primaryColor1,
                    textStyle: TextThemes.subtitle,
                    shadowColor: ConstantColors.shadowColor,
                    height: 40,
                    isLoading: state is ReportLoading,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
