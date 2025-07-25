import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/data/models/login.dart';
import 'package:sop_mobile/presentation/state/brief/brief_bloc.dart';
import 'package:sop_mobile/presentation/state/brief/brief_event.dart';
import 'package:sop_mobile/presentation/state/brief/brief_state.dart';
import 'package:sop_mobile/presentation/state/counter/counter_cubit.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';
import 'package:sop_mobile/presentation/state/permission/camera_cubit.dart';
import 'package:sop_mobile/presentation/state/photo/photo_bloc.dart';
import 'package:sop_mobile/presentation/state/photo/photo_event.dart';
import 'package:sop_mobile/presentation/state/photo/photo_state.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/counter.dart';
import 'package:sop_mobile/presentation/widgets/filter.dart';
import 'package:sop_mobile/presentation/widgets/loading.dart';
import 'package:sop_mobile/presentation/widgets/snackbar.dart';
import 'package:sop_mobile/presentation/widgets/text.dart';
import 'package:sop_mobile/presentation/widgets/textformfield.dart';
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
    final cameraCubit = context.read<CameraCubit>();
    final photoBloc = context.read<PhotoBloc>();

    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          automaticallyImplyLeading: true,
          backgroundColor: ConstantColors.primaryColor1,
          title: const Text('Morning Briefing', style: TextThemes.subtitle),
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
        // providers: StateManager.getBriefBlocProviders(),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ~:Page Title:~
                            CustomText.subtitle(
                              text: 'Informasi Briefing',
                              themes: TextThemes.subtitle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // ~:Page Description:~
                            CustomText.normal(
                              text: 'Masukkan data untuk membuat laporan pagi.',
                            ),
                          ],
                        ),

                        // ~:Location Textfield:~
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            if (state is LoginSuccess) {
                              // ~:Set the location controller text:~
                              locationController.text = state.getUserCreds.name;
                            }

                            return CustomTextFormField(
                              'your location',
                              'Location',
                              const Icon(Icons.location_pin),
                              locationController,
                              inputFormatters: [Formatter.normalFormatter],
                              borderRadius: 20,
                              isEnabled: false,
                            );
                          },
                        ),

                        // ~:Counter Section:~
                        Wrap(
                          runSpacing: 10,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            // ~:Number of Shop Manager:~
                            Counter.person(
                              context,
                              'shop_manager',
                              'Shop Manager',
                            ),

                            // ~:Number of Sales Counter:~
                            Counter.person(
                              context,
                              'sales_counter',
                              'Sales Counter',
                            ),

                            // ~:Number of Salesman:~
                            Counter.person(context, 'salesman', 'Salesman'),

                            // ~:Number of Others:~
                            Counter.person(context, 'others', 'Other'),

                            // ~:Total Person:~
                            Counter.automaticPerson(
                              context,
                              'total',
                              'Jumlah Peserta',
                            ),
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ),

                        // ~:Image Section:~
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
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
                                  log('Camera permission state: $state');
                                  if (state is PhotoUploadFail) {
                                    CustomSnackbar.showSnackbar(
                                      context,
                                      state.error,
                                    );
                                  } else if (state is PhotoDeleteSuccess) {
                                    CustomSnackbar.showSnackbar(
                                      context,
                                      'Photo deleted successfully',
                                    );
                                  } else if (state is PhotoDeleteFail) {
                                    CustomSnackbar.showSnackbar(
                                      context,
                                      state.error,
                                    );
                                  } else if (state is PhotoPermissionGranted) {
                                    log('Camera Permission granted');
                                    photoBloc.add(UploadPhotoEvent());
                                  } else if (state is PhotoPermissionDenied) {
                                    log('Camera Permission denied');
                                    CustomSnackbar.showSnackbar(
                                      context,
                                      'Camera permission denied',
                                    );
                                  } else if (state is PhotoPermissionError) {
                                    log(
                                      'Camera Permission error: ${state.error}',
                                    );
                                    CustomSnackbar.showSnackbar(
                                      context,
                                      state.error,
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
                                                            16,
                                                          ),
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
                                              onTap:
                                                  () => photoBloc.add(
                                                    DeletePhotoEvent(
                                                      state.photoUrl,
                                                    ),
                                                  ),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ConstantColors
                                                          .primaryColor2,
                                                  shape: BoxShape.circle,
                                                ),
                                                padding: const EdgeInsets.all(
                                                  4,
                                                ),
                                                child: const Icon(
                                                  Icons.close_rounded,
                                                  size: 16,
                                                  color:
                                                      ConstantColors
                                                          .primaryColor3,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  return InkWell(
                                    onTap: () async {
                                      log(
                                        'Camera permission: ${cameraCubit.state}',
                                      );
                                      await cameraCubit.checkCameraPermission();
                                      if (cameraCubit.state ==
                                              PermissionStatus.denied ||
                                          cameraCubit.state ==
                                              PermissionStatus
                                                  .permanentlyDenied) {
                                        log('Requesting camera permission');
                                        await cameraCubit
                                            .requestCameraPermission()
                                            .then((_) {
                                              photoBloc.add(
                                                CheckCameraPermission(
                                                  cameraCubit.state,
                                                ),
                                              );
                                            });
                                      } else {
                                        log(
                                          'Camera permission: ${cameraCubit.state}',
                                        );
                                        photoBloc.add(
                                          CheckCameraPermission(
                                            cameraCubit.state,
                                          ),
                                        );
                                      }
                                    },
                                    child: SizedBox(
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
                                    ),
                                  );
                                },
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
                    // log('Location: ${locationController.text}');
                    // log('Number of participants:');
                    // context.read<CounterCubit>().getCount().forEach((key, value) {
                    //   log('$key - $value');
                    // });
                    // log('Description: ${descriptionController.text}');

                    String pic = '';
                    if (photoBloc.state is! PhotoInitial &&
                        (photoBloc.state as PhotoUploadSuccess)
                            .photoUrl
                            .isNotEmpty) {
                      pic = (photoBloc.state as PhotoUploadSuccess).photoUrl;
                    } else {
                      // log('No photo uploaded');
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
                        pic,
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
                    height: 24,
                    child: BlocConsumer<BriefBloc, BriefState>(
                      listener: (context, state) {
                        if (state is BriefCreationSuccess) {
                          // ~:Inform the user:~
                          CustomSnackbar.showSnackbar(
                            context,
                            'Briefing report created successfully',
                          );

                          // ~:Get the latest data:~
                          Filter.onRefreshOrDateChanged(context);

                          // ~:Return to the home page:~
                          Navigator.pop(context);
                        } else if (state is BriefCreationFail) {
                          // ~:Inform the user:~
                          CustomSnackbar.showSnackbar(context, state.error);
                        }
                      },
                      builder: (context, state) {
                        if (state is BriefLoading) {
                          return Loading.platformIndicator(
                            iosRadius: 10,
                            iosCircleColor: ConstantColors.primaryColor3,
                            androidWidth: 20,
                            androidHeight: 20,
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
      ),
    );
  }
}
