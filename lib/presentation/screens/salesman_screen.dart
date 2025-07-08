import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/data/models/report.dart';
import 'package:sop_mobile/data/models/sales_import.dart';
import 'package:sop_mobile/presentation/state/cubit/sales_status.dart';
import 'package:sop_mobile/presentation/state/import/import_bloc.dart';
import 'package:sop_mobile/presentation/state/import/import_event.dart';
import 'package:sop_mobile/presentation/state/import/import_state.dart';
import 'package:sop_mobile/presentation/state/permission/storage_cubit.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_bloc.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_event.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_state.dart';
import 'package:sop_mobile/presentation/state/cubit/sales_position.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/buttons.dart';
import 'package:sop_mobile/presentation/widgets/card.dart';
import 'package:sop_mobile/presentation/widgets/dialog.dart';
import 'package:sop_mobile/presentation/widgets/dropdown.dart';
import 'package:sop_mobile/presentation/widgets/functions.dart';
import 'package:sop_mobile/presentation/widgets/loading.dart';
import 'package:sop_mobile/presentation/widgets/refresh.dart';
import 'package:sop_mobile/presentation/widgets/snackbar.dart';
import 'package:sop_mobile/presentation/widgets/textformfield.dart';

class SalesmanScreen extends StatefulWidget {
  const SalesmanScreen({super.key});

  @override
  State<SalesmanScreen> createState() => _SalesmanScreenState();
}

class _SalesmanScreenState extends State<SalesmanScreen> {
  final PanelController panelController = PanelController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  Future<void> _onImportButtonPressed(BuildContext context) async {
    final storageCubit = context.read<StorageCubit>();
    final importBloc = context.read<ImportBloc>();

    // This implementation assumes `askStoragePermission` can be modified
    // to be an `async` method that returns the `PermissionStatus`.
    final permissionStatus = await storageCubit.askStoragePermission();

    if (!context.mounted) return;

    if (permissionStatus.isGranted) {
      importBloc.add(ImportExcelEvent());
    } else {
      CustomSnackbar.showSnackbar(
        context,
        'Storage permission is required to import files',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final salesPositionCubit = context.read<SalesPositionCubit>();
    final salesmanBloc = context.read<SalesmanBloc>();
    final salesStatusCubit = context.read<SalesStatusCubit>();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SlidingUpPanel(
        controller: panelController,
        renderPanelSheet: false,
        minHeight: 0,
        maxHeight: 450,
        isDraggable: false,
        panelSnapping: false,
        defaultPanelState: PanelState.CLOSED,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        // margin: const EdgeInsets.all(12),
        backdropEnabled: true,
        backdropColor: ConstantColors.backdropColor,
        panel: DecoratedBox(
          decoration: const BoxDecoration(
            color: ConstantColors.primaryColor2,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 20,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ~:Panel Header:~
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ~:Page Title:~
                            DefaultTextStyle(
                              style: TextThemes.subtitle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              child: const Text('Tambah Sales'),
                            ),
                            // ~:Page Description:~
                            DefaultTextStyle(
                              style: TextThemes.normal.copyWith(
                                overflow: TextOverflow.visible,
                              ),
                              child: const Text(
                                'Masukkan data diri sales untuk pembuatan laporan harian.',
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ~:Close Panel Button with outline border, circle shape, and grey shadow:~
                      DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 1.5,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: ConstantColors.shadowColor,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: IconButton(
                          onPressed: () => panelController.close(),
                          icon: const Icon(Icons.close_rounded, size: 20),
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),

                // ~:Panel Body:~
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              spacing: 8,
                              children: [
                                // ~:ID TextField:~
                                CustomTextFormField(
                                  'sales id',
                                  'ID',
                                  const Icon(Icons.person),
                                  borderRadius: 20,
                                  idController,
                                  keyboardType: TextInputType.number,
                                  enableValidator: true,
                                  validatorType: 'id',
                                  inputFormatters: [Formatter.numberFormatter],
                                  isLabelFloat: true,
                                ),

                                // ~:Name TextField:~
                                CustomTextFormField(
                                  'sales name',
                                  'Name',
                                  const Icon(Icons.person),
                                  borderRadius: 20,
                                  nameController,
                                  enableValidator: true,
                                  validatorType: 'name',
                                  textCapitalization: TextCapitalization.words,
                                  inputFormatters: [Formatter.normalFormatter],
                                  isLabelFloat: true,
                                ),

                                Column(
                                  spacing: 16,
                                  children: [
                                    // ~:Position Dropdown:~
                                    CustomDropdown.salesPosition(
                                      salesPositionCubit,
                                      ['Sales Counter', 'Salesman'],
                                      'Position',
                                    ),

                                    // ~:Status Dropdown:~
                                    CustomDropdown.salesStatus(
                                      salesStatusCubit,
                                      ['Aktif', 'Non-Aktif'],
                                      'Status',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ~:Button Section:~
                        Row(
                          spacing: 12,
                          children: [
                            // ~:Cancel Button:~
                            Expanded(
                              child: CustomButton.primaryButton2(
                                context: context,
                                height: 40,
                                text: 'Batal',
                                func: () => panelController.close(),
                                bgColor: ConstantColors.primaryColor2,
                                textStyle: TextThemes.subtitle,
                                shadowColor: ConstantColors.shadowColor,
                                spreadRadius: 2,
                              ),
                            ),

                            // ~:Add Button:~
                            Expanded(
                              child: BlocConsumer<SalesmanBloc, SalesmanState>(
                                listener: (context, state) {
                                  if (state is SalesmanError) {
                                    CustomSnackbar.showSnackbar(
                                      context,
                                      state.error,
                                    );
                                  } else if (state is SalesmanAdded) {
                                    CustomSnackbar.showSnackbar(
                                      context,
                                      'Salesman added successfully',
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return CustomButton.primaryButton2(
                                    context: context,
                                    height: 40,
                                    text: 'Tambah',
                                    func: () {
                                      CustomFunctions.addSalesman(
                                        salesmanBloc,
                                        panelController,
                                        [
                                          NewSalesModel(
                                            id: idController.text,
                                            name: nameController.text,
                                            tier:
                                                salesPositionCubit
                                                    .getSalesPosition(),
                                            isActive:
                                                salesStatusCubit
                                                        .getSalesStatus()
                                                    ? 1
                                                    : 0,
                                          ),
                                        ],
                                      );
                                    },
                                    bgColor: ConstantColors.primaryColor1,
                                    textStyle: TextThemes.subtitle,
                                    shadowColor: ConstantColors.shadowColor,
                                    spreadRadius: 2,
                                    isLoading: state is SalesmanLoading,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          top: false,
          left: false,
          right: false,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              scrolledUnderElevation: 0.0,
              automaticallyImplyLeading: true,
              backgroundColor: ConstantColors.primaryColor1,
              title: const Text('Salesman', style: TextThemes.subtitle),
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
                      icon: const Icon(Icons.arrow_back_rounded, size: 20),
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
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  children: [
                    // ~:Page Header:~
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ~:Page Title:~
                        Text(
                          'Daftar Salesman',
                          style: TextThemes.subtitle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // ~:Page Description:~
                        const Text(
                          'Data diri salesman yang telah terdaftar di sistem.',
                          style: TextThemes.normal,
                        ),
                      ],
                    ),

                    // ~:Page Body:~
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          if (args != null &&
                              args.containsKey('registeredSales') &&
                              (args['registeredSales'] as List<SalesmanModel>)
                                  .isNotEmpty) {
                            log(
                              'Registered sales list: ${args['registeredSales']}',
                            );

                            return SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Column(
                                  spacing: 8.0,
                                  children:
                                      (args['registeredSales'] as List<SalesmanModel>).map((
                                        salesProfile,
                                      ) {
                                        return Card(
                                          color: ConstantColors.primaryColor2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          elevation: 5,
                                          shadowColor:
                                              ConstantColors.shadowColor,
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                  vertical: 4,
                                                  horizontal: 20,
                                                ),
                                            title: Text(
                                              'ID ${Formatter.toTitleCase(salesProfile.idCardNumber)}',
                                              style: TextThemes.normal.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: Text(
                                              '${Formatter.toTitleCase(salesProfile.name)} - ${Formatter.toTitleCase(salesProfile.tierLevel)}',
                                              style: TextThemes.normal,
                                            ),
                                            // ~:Change to CheckBox for further use:~
                                            // trailing: IconButton(
                                            //   icon: const Icon(
                                            //     Icons.delete_rounded,
                                            //     color: ConstantColors.primaryColor3,
                                            //   ),
                                            //   onPressed: () {},
                                            // ),
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ),
                            );
                          }

                          return Refresh.iOSnAndroid(
                            onRefresh: () => salesmanBloc.add(FetchSalesman()),
                            child: BlocBuilder<SalesmanBloc, SalesmanState>(
                              builder: (context, state) {
                                if (state is SalesmanLoading) {
                                  return SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.725,
                                    child: Loading.platformIndicator(
                                      iosRadius: 13,
                                      iosCircleColor:
                                          ConstantColors.primaryColor3,
                                      androidWidth: 28,
                                      androidHeight: 28,
                                      androidStrokeWidth: 3.5,
                                      androidCircleColor:
                                          ConstantColors.primaryColor3,
                                    ),
                                  );
                                } else if (state is SalesmanError) {
                                  return Container(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.7,
                                    alignment: Alignment.center,
                                    child: Text(
                                      state.error,
                                      style: TextThemes.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }

                                return CustomCard.salesmanProfile(
                                  salesmanBloc,
                                  state.fetchSalesList,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    // ~:Page Footer:~
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Builder(
                        builder: (context) {
                          if (args != null &&
                              args.containsKey('registeredSales') &&
                              (args['registeredSales'] as List<SalesmanModel>)
                                  .isNotEmpty) {
                            return const SizedBox();
                          }

                          return Row(
                            spacing: 8,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ~:Delete Button:~
                              CustomButton.primaryButton2(
                                context: context,
                                width: 40,
                                height: 40,
                                enableIcon: true,
                                icon: Icons.delete_rounded,
                                func: () {},
                                bgColor: ConstantColors.primaryColor2,
                                textStyle: TextThemes.normal,
                                shadowColor: ConstantColors.primaryColor1,
                              ),

                              // ~:Import File Button:~
                              BlocConsumer<ImportBloc, ImportState>(
                                listener: (context, state) {
                                  if (state is ImportExcelSucceed) {
                                    CustomFunctions.displayDialog(
                                      context,
                                      CustomDialog.alertSalesImport(
                                        context,
                                        state.salesmanList,
                                        () {
                                          CustomFunctions.addSalesman(
                                            salesmanBloc,
                                            panelController,
                                            state.salesmanList,
                                          );

                                          Navigator.pop(context);
                                        },
                                      ),
                                    );
                                  } else if (state is ImportExcelFailed) {
                                    CustomSnackbar.showSnackbar(
                                      context,
                                      state.message,
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return CustomButton.primaryButton2(
                                    context: context,
                                    width: 40,
                                    height: 40,
                                    enableIcon: true,
                                    icon: Icons.upload_rounded,
                                    func: () => _onImportButtonPressed(context),
                                    bgColor: ConstantColors.primaryColor2,
                                    textStyle: TextThemes.normal,
                                    shadowColor: ConstantColors.primaryColor1,
                                    isLoading: state is ImportLoading,
                                  );
                                },
                              ),

                              // ~:Edit Button:~
                              // CustomButton.primaryButton2(
                              //   context: context,
                              //   width: 40,
                              //   height: 40,
                              //   enableIcon: true,
                              //   icon: Icons.edit_rounded,
                              //   func: () {},
                              //   bgColor: ConstantColors.primaryColor2,
                              //   textStyle: TextThemes.normal,
                              //   shadowColor: ConstantColors.primaryColor1,
                              // ),
                              //
                              // ~:Delete Button:~
                              // CustomButton.primaryButton2(
                              //   context: context,
                              //   width: 40,
                              //   height: 40,
                              //   enableIcon: true,
                              //   icon: Icons.delete_rounded,
                              //   func: () {},
                              //   bgColor: ConstantColors.primaryColor2,
                              //   textStyle: TextThemes.normal,
                              //   shadowColor: ConstantColors.primaryColor1,
                              // ),

                              // ~:Save Button:~
                              Expanded(
                                child: CustomButton.primaryButton2(
                                  context: context,
                                  height: 40,
                                  text: 'Tambah Sales',
                                  func: () => panelController.open(),
                                  bgColor: ConstantColors.primaryColor1,
                                  textStyle: TextThemes.normal,
                                  shadowColor: ConstantColors.primaryColor1,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
