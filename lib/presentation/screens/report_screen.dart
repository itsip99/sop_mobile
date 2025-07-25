import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/core/constant/enum.dart';
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
  final TextEditingController personController = TextEditingController();

  late LeasingInsertDataSource _leasingDataSource;
  late SalesmanInsertDataSource _salesmanDataSource;
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
      stuBloc.add(ModifyStuData(rowIndex: rowIndex, newResultValue: newValue));
    } else if (columnName == 'Target') {
      stuBloc.add(ModifyStuData(rowIndex: rowIndex, newTargetValue: newValue));
    } else if (columnName == 'LM') {
      stuBloc.add(ModifyStuData(rowIndex: rowIndex, newLmValue: newValue));
    }
  }

  void editPaymentValue(
    PaymentBloc paymentBloc,
    int rowIndex,
    String columnName,
    int newValue,
  ) {
    if (columnName == 'Result') {
      paymentBloc.add(
        PaymentDataModified(rowIndex: rowIndex, newResultValue: newValue),
      );
    } else if (columnName == 'LM') {
      paymentBloc.add(
        PaymentDataModified(rowIndex: rowIndex, newTargetValue: newValue),
      );
    }
  }

  void editLeasingValue(
    LeasingBloc leasingBloc,
    int rowIndex,
    String columnName,
    int newValue,
  ) {
    log('Column name: $columnName');
    if (columnName == 'Accepted') {
      // 'accept'
      leasingBloc.add(
        LeasingDataModified(
          rowIndex: rowIndex,
          columnName: columnName,
          newValue: newValue,
        ),
      );
    } else if (columnName == 'Rejected') {
      // 'reject'
      leasingBloc.add(
        LeasingDataModified(
          rowIndex: rowIndex,
          columnName: columnName,
          newValue: newValue,
        ),
      );
    } else if (columnName == 'SPK') {
      // 'spk'
      leasingBloc.add(
        LeasingDataModified(
          rowIndex: rowIndex,
          columnName: columnName,
          newValue: newValue,
        ),
      );
    } else if (columnName == 'Opened') {
      // 'opened'
      leasingBloc.add(
        LeasingDataModified(
          rowIndex: rowIndex,
          columnName: columnName,
          newValue: newValue,
        ),
      );
    }
  }

  void editSalesmanValue(
    SalesmanBloc salesmanBloc,
    int rowIndex,
    String columnName,
    int newValue,
  ) {
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
      salesmanBloc.add(
        ModifySalesman(
          rowIndex: rowIndex,
          columnName: columnName,
          newValue: newValue,
        ),
      );
    } else if (columnName == 'STU') {
      // 'STU'
      salesmanBloc.add(
        ModifySalesman(
          rowIndex: rowIndex,
          columnName: columnName,
          newValue: newValue,
        ),
      );
    } else if (columnName == 'STU LM') {
      // 'STU LM'
      salesmanBloc.add(
        ModifySalesman(
          rowIndex: rowIndex,
          columnName: columnName,
          newValue: newValue,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize data source with initial empty data
    _leasingDataSource = LeasingInsertDataSource(
      [],
      onCellValueEdited:
          (rowIndex, columnName, newValue) => editLeasingValue(
            context.read<LeasingBloc>(),
            rowIndex,
            columnName,
            newValue,
          ),
    );

    _salesmanDataSource = SalesmanInsertDataSource(
      [],
      onCellValueEdited:
          (rowIndex, columnName, newValue) => editSalesmanValue(
            context.read<SalesmanBloc>(),
            rowIndex,
            columnName,
            newValue,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          automaticallyImplyLeading: true,
          backgroundColor: ConstantColors.primaryColor1,
          title: const Text('Daily Report', style: TextThemes.subtitle),
          centerTitle: true,
          leading: Builder(
            builder: (context) {
              if (Platform.isIOS) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 15),
                  onPressed: () => Navigator.pop(context),
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, size: 20),
                  onPressed: () => Navigator.pop(context),
                );
              }
            },
          ),
        ),
        body: DecoratedBox(
          decoration: const BoxDecoration(color: ConstantColors.primaryColor1),
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
                    Text(
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
                                    locationController
                                        .text = Formatter.toTitleCase(
                                      state.getUserCreds.name,
                                    );
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
                                        '${state.getUserCreds.branch} ${Formatter.toTitleCase(state.getUserCreds.branchName)}';
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
                                  tableHeight: 310,
                                  StuType.values
                                      .map((e) => e.name.toString())
                                      .toList(),
                                  allowEditing: true,
                                  horizontalScrollPhysics:
                                      const BouncingScrollPhysics(),
                                  textStyle: TextThemes.normal,
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
                                  textStyle: TextThemes.normal,
                                );
                              },
                            ),

                            // ~:Leasing Input Table:~
                            BlocBuilder<LeasingBloc, LeasingState>(
                              builder: (context, state) {
                                tableHeight = 410;
                                leasingData = state.data;

                                if (state is AddLeasingData) {
                                  leasingData = state.newData;
                                  // Update the existing data source with new data
                                  _leasingDataSource.updateData(leasingData);
                                } else if (state is LeasingInitial) {
                                  // Handle initial state
                                  _leasingDataSource.updateData(leasingData);
                                }

                                log('Leasing length: ${state.data.length}');
                                return CustomDataGrid.report(
                                  context,
                                  _leasingDataSource,
                                  LeasingType.values
                                      .map((e) => e.name.toString())
                                      .toList(),
                                  tableHeight: tableHeight,
                                  allowEditing: true,
                                  horizontalScrollPhysics:
                                      const BouncingScrollPhysics(),
                                  textStyle: TextThemes.normal,
                                );
                              },
                            ),

                            // ~:Salesman Input Table:~
                            BlocBuilder<SalesmanBloc, SalesmanState>(
                              builder: (context, state) {
                                salesData =
                                    state.fetchSalesList
                                        .where((e) => e.isActive == 1)
                                        .toList();
                                if (state is SalesmanLoading) {
                                  return Loading.platformIndicator(
                                    iosRadius: 13,
                                    iosCircleColor:
                                        ConstantColors.primaryColor3,
                                    androidWidth: 28,
                                    androidHeight: 28,
                                    androidStrokeWidth: 3.5,
                                    androidCircleColor:
                                        ConstantColors.primaryColor3,
                                  );
                                } else if (state is SalesmanFetched) {
                                  salesmanData = state.salesDataList;
                                  _salesmanDataSource.updateData(salesmanData);
                                } else if (state is SalesmanModified) {
                                  salesmanData = state.newData;
                                  _salesmanDataSource.updateData(salesmanData);
                                }
                                log('Salesman length: ${salesmanData.length}');

                                tableHeight = 120;
                                if (salesmanData.length < 6) {
                                  tableHeight += double.parse(
                                    (50 * salesmanData.length).toString(),
                                  );
                                } else {
                                  tableHeight = 410;
                                }

                                // ~:Set a dynamic table height:~
                                if (salesmanData.isEmpty) {
                                  return const SizedBox();
                                }

                                return CustomDataGrid.report(
                                  context,
                                  _salesmanDataSource,
                                  SalesmanType.values
                                      .map((e) => e.name.toString())
                                      .toList(),
                                  tableHeight: tableHeight,
                                  rowHeaderWidth: 75,
                                  allowEditing: true,
                                  horizontalScrollPhysics:
                                      const BouncingScrollPhysics(),
                                  verticalScrollPhysics:
                                      salesmanData.length < 6
                                          ? const NeverScrollableScrollPhysics()
                                          : const AlwaysScrollableScrollPhysics(),
                                  columnWidthMode:
                                      ColumnWidthMode.fitByCellValue,
                                  textStyle: TextThemes.normal,
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
                      CustomSnackbar.showSnackbar(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    return CustomButton.primaryButton2(
                      context: context,
                      text: 'Buat',
                      func: () {
                        // for (int i = 0; i < salesmanData.length; i++) {
                        //   log(
                        //     salesData
                        //         .where(
                        //           (e) => e.userName == salesmanData[i].name,
                        //         )
                        //         .first
                        //         .id,
                        //   );
                        // }
                        for (int i = 0; i < salesData.length; i++) {
                          log(salesData[i].userName);
                        }
                        log('');
                        for (int i = 0; i < salesmanData.length; i++) {
                          log(salesmanData[i].name);
                        }
                        // context.read<ReportBloc>().add(
                        //   CreateReport(
                        //     dealerName: locationController.text,
                        //     areaName: areaController.text.split(' ')[0],
                        //     personInCharge: personController.text,
                        //     stuData: stuData,
                        //     paymentData: paymentData,
                        //     leasingData: leasingData,
                        //     salesmanData: salesmanData,
                        //     salesData: salesData,
                        //   ),
                        // );
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
      ),
    );
  }
}
