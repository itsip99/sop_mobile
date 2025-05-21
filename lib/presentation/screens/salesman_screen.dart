import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/presentation/state/cubit/sales.dart';
import 'package:sop_mobile/presentation/state/route/route_bloc.dart';
import 'package:sop_mobile/presentation/state/route/route_event.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_bloc.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_event.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_state.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/buttons.dart';
import 'package:sop_mobile/presentation/widgets/dropdown.dart';
import 'package:sop_mobile/presentation/widgets/loading.dart';
import 'package:sop_mobile/presentation/widgets/textformfield.dart';
import 'package:sop_mobile/routes.dart';

class SalesmanScreen extends StatefulWidget {
  const SalesmanScreen({super.key});

  @override
  State<SalesmanScreen> createState() => _SalesmanScreenState();
}

class _SalesmanScreenState extends State<SalesmanScreen> {
  final PanelController panelController = PanelController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final salesStatusCubit = context.read<SalesStatusCubit>();
    final salesmanBloc = context.read<SalesmanBloc>();

    return SlidingUpPanel(
      controller: panelController,
      renderPanelSheet: false,
      minHeight: 0,
      maxHeight: 400,
      isDraggable: false,
      panelSnapping: false,
      defaultPanelState: PanelState.CLOSED,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      margin: const EdgeInsets.all(12),
      backdropEnabled: true,
      backdropColor: ConstantColors.backdropColor,
      panel: DecoratedBox(
        decoration: const BoxDecoration(
          color: ConstantColors.primaryColor2,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // ~:Panel Header:~
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ~:Page Title:~
                          DefaultTextStyle(
                            style: TextThemes.subtitle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            child: const Text('Informasi Sales'),
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
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 20,
                        ),
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),

              // ~:Panel Body:~
              Material(
                child: AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    spacing: 12,
                    children: [
                      // ~:Email TextField:~
                      CustomTextFormField(
                        'sales name',
                        'Name',
                        const Icon(Icons.person),
                        borderRadius: 20,
                        nameController,
                        enableValidator: true,
                        validatorType: 'name',
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [
                          Formatter.normalFormatter,
                        ],
                        isLabelFloat: true,
                      ),

                      // ~:Status Dropdown:~
                      CustomDropdown.sales(
                        salesStatusCubit,
                        ['Sales Counter', 'Freelance', 'Gold', 'Platinum'],
                        'Status',
                      ),

                      // ~:Add Button:~
                      CustomButton.primaryButton2(
                        context: context,
                        height: 40,
                        text: 'Tambah Salesman',
                        func: () {
                          log('Add new salesman');
                          log('Name: ${nameController.text}');
                          log('Status: ${salesStatusCubit.getSalesStatus()}');
                          salesmanBloc.add(AddSalesman(
                            nameController.text,
                            salesStatusCubit.getSalesStatus(),
                          ));
                        },
                        bgColor: ConstantColors.primaryColor2,
                        textStyle: TextThemes.subtitle,
                        shadowColor: ConstantColors.primaryColor1,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // toolbarHeight: 100,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          automaticallyImplyLeading: true,
          backgroundColor: ConstantColors.primaryColor1,
          title: const Text(
            'Salesman',
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
                  onPressed: () {
                    context
                        .read<RouteBloc>()
                        .add(RoutePop(ConstantRoutes.home));
                    Navigator.pop(context);
                  },
                );
              } else {
                return IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    size: 20,
                  ),
                  onPressed: () {
                    context
                        .read<RouteBloc>()
                        .add(RoutePop(ConstantRoutes.home));
                    Navigator.pop(context);
                  },
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
              children: [
                // ~:Page Header:~
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ~:Page Title:~
                    Text(
                      'Informasi Sales',
                      style: TextThemes.subtitle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // ~:Page Description:~
                    const Text(
                      'Masukkan data diri sales untuk pembuatan laporan harian.',
                      style: TextThemes.normal,
                    ),
                  ],
                ),

                // ~:Divider:~
                const SizedBox(height: 10),

                // ~:Page Body:~
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: BlocConsumer<SalesmanBloc, SalesmanState>(
                      listener: (context, state) {
                        if (state is SalesmanAdded) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Salesman added successfully'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else if (state is SalesmanError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is SalesmanLoading) {
                          return Loading.platformIndicator(
                            iosRadius: 13,
                            iosCircleColor: ConstantColors.primaryColor3,
                            androidWidth: 28,
                            androidHeight: 28,
                            androidStrokeWidth: 3.5,
                            androidCircleColor: ConstantColors.primaryColor3,
                          );
                        } else {
                          log('Salesman list length: ${state.salesProfileList.length}');
                          return SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            child: Column(
                              children:
                                  state.salesProfileList.map((salesProfile) {
                                return Column(
                                  children: [
                                    Text(salesProfile.name),
                                    Text(salesProfile.tier),
                                  ],
                                );
                              }).toList(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),

                // ~:Divider:~
                const SizedBox(height: 10),

                // ~:Page Footer:~
                Row(
                  spacing: 8,
                  children: [
                    // ~:Add Button:~
                    CustomButton.primaryButton2(
                      context: context,
                      width: 40,
                      height: 40,
                      enableIcon: true,
                      icon: Icons.add_rounded,
                      func: () => panelController.open(),
                      bgColor: ConstantColors.primaryColor2,
                      textStyle: TextThemes.normal,
                      shadowColor: ConstantColors.primaryColor1,
                    ),

                    // ~:Edit Button:~
                    CustomButton.primaryButton2(
                      context: context,
                      width: 40,
                      height: 40,
                      enableIcon: true,
                      icon: Icons.edit_rounded,
                      func: () {},
                      bgColor: ConstantColors.primaryColor2,
                      textStyle: TextThemes.normal,
                      shadowColor: ConstantColors.primaryColor1,
                    ),

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

                    // ~:Save Button:~
                    Expanded(
                      child: CustomButton.primaryButton2(
                        context: context,
                        height: 40,
                        text: 'Save',
                        func: () {},
                        bgColor: ConstantColors.primaryColor1,
                        textStyle: TextThemes.normalWhite,
                        shadowColor: ConstantColors.primaryColor1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
