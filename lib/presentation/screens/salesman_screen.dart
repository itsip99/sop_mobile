import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/presentation/state/route/route_bloc.dart';
import 'package:sop_mobile/presentation/state/route/route_event.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_bloc.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_state.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/buttons.dart';
import 'package:sop_mobile/presentation/widgets/textformfield.dart';
import 'package:sop_mobile/routes.dart';

class SalesmanScreen extends StatefulWidget {
  const SalesmanScreen({super.key});

  @override
  State<SalesmanScreen> createState() => _SalesmanScreenState();
}

class _SalesmanScreenState extends State<SalesmanScreen> {
  String selectedStatus = 'sales counter';
  final TextEditingController locationController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

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
                  context.read<RouteBloc>().add(RoutePop(ConstantRoutes.home));
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
                  context.read<RouteBloc>().add(RoutePop(ConstantRoutes.home));
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
                child: BlocBuilder<SalesmanBloc, SalesmanState>(
                  builder: (context, state) {
                    return ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 2),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              // ~:Email TextField:~
                              CustomTextFormField(
                                'sales name',
                                'Name',
                                const Icon(Icons.person),
                                nameController,
                                enableValidator: true,
                                validatorType: 'username',
                                enableUpperCaseText: true,
                                inputFormatters: [
                                  CapitalFormatter(),
                                  Formatter.capitalFormatter,
                                ],
                              ),

                              // ~:Status Dropdown:~
                              DropdownButtonFormField<String>(
                                value: selectedStatus,
                                items: const [
                                  DropdownMenuItem(
                                    value: "sales counter",
                                    child: Text("Sales Counter"),
                                  ),
                                  DropdownMenuItem(
                                    value: "freelance",
                                    child: Text("Freelance"),
                                  ),
                                  DropdownMenuItem(
                                    value: "gold",
                                    child: Text("Gold"),
                                  ),
                                  DropdownMenuItem(
                                    value: "platinum",
                                    child: Text("Platinum"),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    selectedStatus = value;
                                  }
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Status',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    borderSide: BorderSide(
                                      color: ConstantColors.primaryColor3,
                                    ),
                                  ),
                                ),
                              ),

                              // ~:Divider:~
                              const SizedBox(height: 16),

                              // ~:Add Button:~
                              CustomButton.primaryButton2(
                                context: context,
                                text: 'Add Salesman',
                                func: () {},
                                bgColor: ConstantColors.primaryColor2,
                                textStyle: TextThemes.subtitle,
                                shadowColor: ConstantColors.primaryColor1,
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // ~:Divider:~
              const SizedBox(height: 10),

              // ~:Page Footer:~
              Row(
                spacing: 8,
                children: [
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
    );
  }
}
