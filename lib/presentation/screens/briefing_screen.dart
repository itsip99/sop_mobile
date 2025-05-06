import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/presentation/state/counter/counter_cubit.dart';
import 'package:sop_mobile/presentation/state/route/route_bloc.dart';
import 'package:sop_mobile/presentation/state/route/route_event.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/textformfield.dart';
import 'package:sop_mobile/routes.dart';

class BriefingScreen extends StatefulWidget {
  const BriefingScreen({super.key});

  @override
  State<BriefingScreen> createState() => _BriefingScreenState();
}

class _BriefingScreenState extends State<BriefingScreen> {
  final TextEditingController locationController = TextEditingController();

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
          'Morning Briefing',
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
          child: Wrap(
            runSpacing: 10,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ~:Page Title:~
                  Text(
                    'Informasi Briefing',
                    style: TextThemes.subtitle,
                  ),

                  // ~:Page Description:~
                  Text(
                    'Masukkan data untuk membuat laporan pagi.',
                    style: TextThemes.normal,
                  ),
                ],
              ),

              // ~:Location Textfield:~
              CustomTextFormField(
                'your location',
                'Location',
                const Icon(Icons.location_pin),
                locationController,
                inputFormatters: [Formatter.normalFormatter],
              ),

              // ~:Counter Section:~
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Jumlah Peserta',
                    style: TextThemes.subtitle,
                  ),
                  BlocBuilder<CounterCubit, int>(
                    builder: (context, count) {
                      return Container(
                        decoration: BoxDecoration(
                          color: ConstantColors.primaryColor1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Wrap(
                          spacing: 12,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            InkWell(
                              onTap: () =>
                                  context.read<CounterCubit>().decrement(count),
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                width: 32,
                                height: 32,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: ConstantColors.primaryColor2,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  size: 16,
                                ),
                              ),
                            ),
                            Text(
                              '$count orang',
                              style: TextThemes.normal,
                            ),
                            // TextFormField(
                            //   controller: personController,
                            //   keyboardType: TextInputType.number,
                            //   decoration: const InputDecoration(
                            //     border: OutlineInputBorder(),
                            //     hintText: 'Enter a number',
                            //   ),
                            //   onChanged: (value) {
                            //     // Dispatch event to update Cubit state
                            //     final newCount = int.tryParse(value) ?? count;
                            //     context.read<CounterCubit>().setCount(newCount);
                            //   },
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please enter a number';
                            //     }
                            //     final parsedValue = int.tryParse(value);
                            //     if (parsedValue == null) {
                            //       return 'Invalid number';
                            //     }
                            //     return null;
                            //   },
                            // ),
                            InkWell(
                              onTap: () =>
                                  context.read<CounterCubit>().increment(count),
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                width: 32,
                                height: 32,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: ConstantColors.primaryColor2,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
