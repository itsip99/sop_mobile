import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/data/models/login.dart';
import 'package:sop_mobile/presentation/state/brief/brief_bloc.dart';
import 'package:sop_mobile/presentation/state/brief/brief_event.dart';
import 'package:sop_mobile/presentation/state/brief/brief_state.dart';
import 'package:sop_mobile/presentation/state/counter/counter_cubit.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';
import 'package:sop_mobile/presentation/state/photo/photo_bloc.dart';
import 'package:sop_mobile/presentation/state/photo/photo_event.dart';
import 'package:sop_mobile/presentation/state/photo/photo_state.dart';
import 'package:sop_mobile/presentation/state/route/route_bloc.dart';
import 'package:sop_mobile/presentation/state/route/route_event.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/counter.dart';
import 'package:sop_mobile/presentation/widgets/loading.dart';
import 'package:sop_mobile/presentation/widgets/snackbar.dart';
import 'package:sop_mobile/presentation/widgets/textformfield.dart';
import 'package:sop_mobile/routes.dart';
import 'package:dotted_border/dotted_border.dart';

class BriefingScreen extends StatefulWidget {
  const BriefingScreen({super.key});

  @override
  State<BriefingScreen> createState() => _BriefingScreenState();
}

class _BriefingScreenState extends State<BriefingScreen> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    final counterCubit = context.read<CounterCubit>();
    final photoBloc = context.read<PhotoBloc>();

    return Scaffold(
      appBar: AppBar(
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
      // providers: StateManager.getBriefBlocProviders(),
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
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
          child: Column(
            children: [
              // ~:Body Section:~
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
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
                      Wrap(
                        runSpacing: 10,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          // ~:Total Person:~
                          Counter.person(context, 'total', 'Jumlah Peserta'),

                          // ~:Number of Shop Manager:~
                          Counter.person(
                              context, 'shop_manager', 'Shop Manager'),

                          // ~:Number of Sales Counter:~
                          Counter.person(
                              context, 'sales_counter', 'Sales Counter'),

                          // ~:Number of Salesman:~
                          Counter.person(context, 'salesman', 'Salesman'),

                          // ~:Number of Others:~
                          Counter.person(context, 'others', 'Other'),
                        ],
                      ),

                      // ~:Description Section:~
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: TextField(
                          controller: descriptionController,
                          maxLines: 8,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ConstantColors.primaryColor2,
                            hintText: 'Enter your description',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintStyle: TextThemes.textfieldPlaceholder,
                            labelText: 'Description',
                            labelStyle: TextThemes.textfieldPlaceholder,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),

                      // ~:Image Section:~
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: InkWell(
                          onTap: () => photoBloc.add(UploadPhotoEvent()),
                          child: DottedBorder(
                            color: ConstantColors.primaryColor3,
                            strokeWidth: 2,
                            dashPattern: const [4, 4],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(16),
                            child: SizedBox(
                              height: 80,
                              child: BlocConsumer<PhotoBloc, PhotoState>(
                                listener: (context, state) {
                                  if (state is PhotoUploadFail) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      CustomSnackbar.type1(
                                        12,
                                        SnackBarBehavior.floating,
                                        16,
                                        state.error,
                                        ConstantColors.shadowColor.shade300,
                                        ConstantColors.primaryColor3,
                                        true,
                                      ),
                                    );
                                  } else if (state is PhotoDeleteSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      CustomSnackbar.type1(
                                        12,
                                        SnackBarBehavior.floating,
                                        16,
                                        'Photo deleted successfully',
                                        ConstantColors.shadowColor.shade300,
                                        ConstantColors.primaryColor3,
                                        true,
                                      ),
                                    );
                                  } else if (state is PhotoDeleteFail) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      CustomSnackbar.type1(
                                        12,
                                        SnackBarBehavior.floating,
                                        16,
                                        state.error,
                                        ConstantColors.shadowColor.shade300,
                                        ConstantColors.primaryColor3,
                                        true,
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is PhotoLoading) {
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
                                  } else if (state is PhotoUploadSuccess) {
                                    return Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Stack(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    backgroundColor:
                                                        ConstantColors
                                                            .primaryColor2,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      child: Image.memory(
                                                        base64Decode(
                                                          state.photoUrl,
                                                        ),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.memory(
                                                base64Decode(state.photoUrl),
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 4,
                                            top: 4,
                                            child: InkWell(
                                              onTap: () => photoBloc.add(
                                                DeletePhotoEvent(
                                                  state.photoUrl,
                                                ),
                                              ),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: ConstantColors
                                                      .primaryColor2,
                                                  shape: BoxShape.circle,
                                                ),
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: const Icon(
                                                  Icons.close_rounded,
                                                  size: 16,
                                                  color: ConstantColors
                                                      .primaryColor3,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: const Wrap(
                                      spacing: 8,
                                      alignment: WrapAlignment.center,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      runAlignment: WrapAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.camera_alt_rounded,
                                          size: 20,
                                        ),
                                        Text(
                                          'Upload Foto',
                                          style: TextThemes.subtitle,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ~:Footer Section:~
              ElevatedButton(
                onPressed: () {
                  log('Location: ${locationController.text}');
                  log('Number of participants:');
                  context.read<CounterCubit>().getCount().forEach((key, value) {
                    log('$key - $value');
                  });
                  log('Description: ${descriptionController.text}');
                  if ((photoBloc.state as PhotoUploadSuccess)
                      .photoUrl
                      .isNotEmpty) {
                    log('Photo is available');
                  } else {
                    log('No photo uploaded');
                  }

                  LoginModel user =
                      (loginBloc.state as LoginSuccess).getUserCreds;

                  context.read<BriefBloc>().add(
                        BriefCreation(
                          user.id,
                          user.branch,
                          user.shop,
                          DateTime.now().toString().split(' ')[0],
                          locationController.text,
                          counterCubit.getCount()['total']!,
                          counterCubit.getCount()['shop_manager']!,
                          counterCubit.getCount()['sales_counter']!,
                          counterCubit.getCount()['salesman']!,
                          counterCubit.getCount()['others']!,
                          descriptionController.text,
                          (photoBloc.state as PhotoUploadSuccess).photoUrl,
                        ),
                      );
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
                  child: BlocConsumer<BriefBloc, BriefState>(
                    listener: (context, state) {
                      if (state is BriefCreationSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackbar.type1(
                            12,
                            SnackBarBehavior.floating,
                            16,
                            'Briefing report created successfully',
                            ConstantColors.shadowColor.shade300,
                            ConstantColors.primaryColor3,
                            true,
                          ),
                        );
                      } else if (state is BriefCreationFail) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackbar.type1(
                            12,
                            SnackBarBehavior.floating,
                            16,
                            state.error,
                            ConstantColors.shadowColor.shade300,
                            ConstantColors.primaryColor3,
                            true,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is BriefLoading) {
                        return Loading.platformIndicator(
                          iosRadius: 13,
                          iosCircleColor: ConstantColors.primaryColor3,
                          androidWidth: 28,
                          androidHeight: 28,
                          androidStrokeWidth: 3.5,
                          androidCircleColor: ConstantColors.primaryColor3,
                        );
                      }

                      return const Text(
                        'Buat',
                        style: TextThemes.subtitle,
                        textAlign: TextAlign.center,
                      );
                    },
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
