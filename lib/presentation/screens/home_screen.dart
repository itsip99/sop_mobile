import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/data/models/home.dart';
import 'package:sop_mobile/presentation/state/counter/counter_cubit.dart';
import 'package:sop_mobile/presentation/state/leasing/leasing_bloc.dart';
import 'package:sop_mobile/presentation/state/cubit/sales_position.dart';
import 'package:sop_mobile/presentation/state/filter/filter_bloc.dart';
import 'package:sop_mobile/presentation/state/filter/filter_state.dart';
import 'package:sop_mobile/presentation/state/leasing/leasing_event.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';
import 'package:sop_mobile/presentation/state/payment/payment_bloc.dart';
import 'package:sop_mobile/presentation/state/payment/payment_event.dart';
import 'package:sop_mobile/presentation/state/photo/photo_bloc.dart';
import 'package:sop_mobile/presentation/state/photo/photo_event.dart';
import 'package:sop_mobile/presentation/state/report/report_bloc.dart';
import 'package:sop_mobile/presentation/state/report/report_event.dart';
import 'package:sop_mobile/presentation/state/route/route_bloc.dart';
import 'package:sop_mobile/presentation/state/route/route_event.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_bloc.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_event.dart';
import 'package:sop_mobile/presentation/state/stu/stu_bloc.dart';
import 'package:sop_mobile/presentation/state/stu/stu_event.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/buttons.dart';
import 'package:sop_mobile/presentation/widgets/card.dart';
import 'package:sop_mobile/presentation/widgets/filter.dart';
import 'package:sop_mobile/presentation/widgets/loading.dart';
import 'package:sop_mobile/presentation/widgets/refresh.dart';
import 'package:sop_mobile/presentation/widgets/snackbar.dart';
import 'package:sop_mobile/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PanelController panelController = PanelController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final routeBloc = context.read<RouteBloc>();
    final counterCubit = context.read<CounterCubit>();
    final photoBloc = context.read<PhotoBloc>();
    final salesProfileBloc = context.read<SalesmanBloc>();
    final salesPositionCubit = context.read<SalesPositionCubit>();

    return SlidingUpPanel(
      controller: panelController,
      renderPanelSheet: false,
      minHeight: 0,
      maxHeight: 200,
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
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const DefaultTextStyle(
                    style: TextThemes.subtitle,
                    child: Text('Buat Laporan / Tambah Data'),
                  ),
                  IconButton(
                    onPressed: () => panelController.close(),
                    icon: const Icon(Icons.close_rounded, size: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // ~:Morning Briefing:~
                  BlocBuilder<FilterBloc, FilterState>(
                    builder: (context, state) {
                      return DefaultTextStyle(
                        style: TextThemes.normalTextButton,
                        child: CustomButton.normalButton(
                          context: context,
                          text: 'Morning Briefing',
                          func: () {
                            log('Status: ${state.toString()}');
                            if ((state is FilterError &&
                                    state.errorMessage == 'No data available' ||
                                (state is FilterSuccess &&
                                    state.briefingData.isEmpty))) {
                              photoBloc.add(InitPhotoEvent());
                              counterCubit.setInitial('total', 1);
                              counterCubit.setInitial('shop_manager', 1);
                              counterCubit.setInitial('sales_counter', 1);
                              counterCubit.setInitial('salesman', 1);
                              counterCubit.setInitial('others', 1);

                              routeBloc.add(RoutePush(ConstantRoutes.brief));
                              Navigator.pushNamed(
                                context,
                                ConstantRoutes.brief,
                              );
                              panelController.close();
                            } else {
                              panelController.close();
                              CustomSnackbar.showSnackbar(
                                context,
                                'Anda tidak dapat membuat laporan pagi lagi karena sudah ada',
                              );
                            }
                          },
                          bgColor: Colors.transparent,
                        ),
                      );
                    },
                  ),
                  const Divider(height: 0.5),
                  DefaultTextStyle(
                    style: TextThemes.normalTextButton,
                    child: CustomButton.normalButton(
                      context: context,
                      text: 'Daily Report',
                      func: () {
                        routeBloc.add(RoutePush(ConstantRoutes.report));

                        // ~:Reset Table Data:~
                        context.read<StuBloc>().add(ResetStuData());
                        context.read<PaymentBloc>().add(ResetPaymentData());
                        context.read<LeasingBloc>().add(ResetLeasingData());
                        log('Salesman data is empty, fetching...');
                        context.read<SalesmanBloc>().add(FetchSalesman());
                        context.read<ReportBloc>().add(InitiateReport());

                        Navigator.pushNamed(context, ConstantRoutes.report);
                        panelController.close();
                      },
                      bgColor: Colors.transparent,
                    ),
                  ),
                  const Divider(height: 0.5),
                  DefaultTextStyle(
                    style: TextThemes.normalTextButton,
                    child: CustomButton.normalButton(
                      context: context,
                      text: 'Salesman',
                      func: () {
                        salesProfileBloc.add(ResetSalesman([]));
                        salesProfileBloc.add(FetchSalesman());
                        salesPositionCubit.setSalesPosition('Sales Counter');
                        routeBloc.add(RoutePush(ConstantRoutes.sales));
                        Navigator.pushNamed(context, ConstantRoutes.sales);
                        panelController.close();
                      },
                      bgColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () => panelController.open(),
          backgroundColor: ConstantColors.primaryColor1,
          child: const Icon(Icons.add, color: ConstantColors.primaryColor3),
        ),
        // ~:Profile Section:~
        appBar: AppBar(
          toolbarHeight: 100,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: ConstantColors.primaryColor1,
          title: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 8),
            child: Wrap(
              spacing: 15,
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.start,
              alignment: WrapAlignment.start,
              children: [
                // ~:Profile Image:~
                CircleAvatar(
                  backgroundColor: ConstantColors.primaryColor2,
                  radius:
                      MediaQuery.of(context).size.shortestSide >= 600
                          ? 52
                          : 32, // Larger on tablets
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // ~:Profile Name:~
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    // ~:Welcome Statement:~
                    const Text('Selamat datang,', style: TextThemes.subtitle),

                    // ~:Profile Name:~
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginFailure) {
                          Navigator.pushReplacementNamed(context, '/welcome');
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginSuccess) {
                          return Text(
                            state.login.name,
                            style: TextThemes.title2.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }

                        return const Text('Guest');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // ~:Utility Section:~
          actions: [
            // // ~:Logout Button:~
            // Padding(
            //   padding: const EdgeInsets.only(right: 8),
            //   child: BlocListener<LoginBloc, LoginState>(
            //     listener: (context, state) {
            //       if (state is LogoutSuccess) {
            //         Navigator.pushReplacementNamed(context, '/welcome');
            //       } else if (state is LogoutFailure) {
            //         CustomSnackbar.showSnackbar(
            //           context,
            //           state.getLogoutFailure,
            //           backgroundColor: ConstantColors.primaryColor3,
            //         );
            //       }
            //     },
            //     child: IconButton(
            //       onPressed: () {
            //         loginBloc.add(LogoutButtonPressed());
            //       },
            //       icon: const Icon(
            //         Icons.logout,
            //         color: ConstantColors.primaryColor3,
            //       ),
            //     ),
            //   ),
            // ),

            // ~:Settings Button:~
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed:
                    () => Navigator.pushNamed(context, ConstantRoutes.settings),
                icon: const Icon(
                  Icons.settings,
                  color: ConstantColors.primaryColor3,
                ),
              ),
            ),
          ],
        ),
        body: DecoratedBox(
          decoration: const BoxDecoration(color: ConstantColors.primaryColor1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: ConstantColors.primaryColor2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  MediaQuery.of(context).size.shortestSide >= 600
                      ? 45
                      : 25, // Larger radius on tablets
                ),
                topRight: Radius.circular(
                  MediaQuery.of(context).size.shortestSide >= 600
                      ? 45
                      : 25, // Larger radius on tablets
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal:
                  MediaQuery.of(context).size.shortestSide >= 600 ? 45 : 15,
              vertical:
                  MediaQuery.of(context).size.shortestSide >= 600 ? 30 : 10,
            ),
            child: Column(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ~:Filter Section:~
                Filter.type1(context),

                // ~:Acts Section:~
                Expanded(
                  child: Refresh.iOSnAndroid(
                    onRefresh: () => Filter.onRefreshOrDateChanged(context),
                    child: BlocBuilder<FilterBloc, FilterState>(
                      builder: (context, state) {
                        if (state is FilterLoading) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Loading.platformIndicator(
                              iosRadius: 13,
                              iosCircleColor: ConstantColors.primaryColor3,
                              androidWidth: 28,
                              androidHeight: 28,
                              androidStrokeWidth: 3.5,
                              androidCircleColor: ConstantColors.primaryColor3,
                            ),
                          );
                        } else if (state is FilterSuccess) {
                          final data = HomeModel(
                            briefingData: state.briefingData,
                            reportData: state.reportData,
                            salesData: state.salesData,
                          );

                          return Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runAlignment: WrapAlignment.center,
                            alignment: WrapAlignment.center,
                            runSpacing: 12,
                            children: [
                              // ~:Briefing Section:~
                              Builder(
                                builder: (context) {
                                  if (data.briefingData.isNotEmpty) {
                                    return CustomCard.briefSection(
                                      context,
                                      MediaQuery.of(context).size.width,
                                      325,
                                      scrollController,
                                      data.briefingData,
                                      MediaQuery.of(context).size.width,
                                      315,
                                      cardMargin: 4.0,
                                      cardAlignment: Alignment.topCenter,
                                    );
                                  }

                                  return const SizedBox();
                                },
                              ),

                              // ~:Report Section:~
                              Builder(
                                builder: (context) {
                                  if (data.reportData.isNotEmpty) {
                                    log(
                                      'STU Data: ${data.reportData[0].stu.length}',
                                    );
                                    return CustomCard.reportSection(
                                      context,
                                      ConstantColors.primaryColor2,
                                      data.reportData[0],
                                    );
                                  }

                                  return const SizedBox();
                                },
                              ),

                              // ~:Salesman Section:~
                              // Builder(builder: (context) {
                              //   if (data.salesData.isNotEmpty) {
                              //     return const Center(
                              //       child: Text('Sales Data'),
                              //     );
                              //   }
                              //
                              //   return const SizedBox();
                              // }),
                            ],
                          );
                        } else if (state is FilterError) {
                          String message = state.errorMessage;
                          if (state.errorMessage.toLowerCase().contains(
                            'connection timed out',
                          )) {
                            message = 'Connection timed out';
                          }

                          return Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            alignment: Alignment.center,
                            child: Text(
                              message,
                              style: TextThemes.normal,
                              textAlign: TextAlign.center,
                            ),
                          );
                        }

                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.7,
                          alignment: Alignment.center,
                          child: Text(
                            'No data available',
                            style: TextThemes.normal,
                            textAlign: TextAlign.center,
                          ),
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
