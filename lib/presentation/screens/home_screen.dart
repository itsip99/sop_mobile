import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/core/constant/state_manager.dart';
import 'package:sop_mobile/data/models/home.dart';
import 'package:sop_mobile/presentation/state/filter/filter_bloc.dart';
import 'package:sop_mobile/presentation/state/filter/filter_state.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_event.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';
import 'package:sop_mobile/presentation/state/route/route_bloc.dart';
import 'package:sop_mobile/presentation/state/route/route_event.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/buttons.dart';
import 'package:sop_mobile/presentation/widgets/card.dart';
import 'package:sop_mobile/presentation/widgets/filter.dart';
import 'package:sop_mobile/presentation/widgets/loading.dart';
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
    log('Width: ${MediaQuery.of(context).size.width}');
    log('Height: ${MediaQuery.of(context).size.height}');

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
      backdropColor: ConstantColors.primaryColor3.withOpacity(0.5),
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
                    child: Text(
                      'Buat Laporan / Tambah Data',
                    ),
                  ),
                  IconButton(
                    onPressed: () => panelController.close(),
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // ~:Morning Briefing:~
                  DefaultTextStyle(
                    style: TextThemes.normalTextButton,
                    child: CustomButton.normalButton(
                      context: context,
                      text: 'Morning Briefing',
                      func: () {
                        context
                            .read<RouteBloc>()
                            .add(RoutePush(ConstantRoutes.brief));
                        Navigator.pushNamed(context, ConstantRoutes.brief);
                        panelController.close();
                      },
                      bgColor: Colors.transparent,
                    ),
                  ),
                  const Divider(
                    height: 0.5,
                  ),
                  DefaultTextStyle(
                    style: TextThemes.normalTextButton,
                    child: CustomButton.normalButton(
                      context: context,
                      text: 'Daily Report',
                      func: () {
                        context
                            .read<RouteBloc>()
                            .add(RoutePush(ConstantRoutes.report));
                        Navigator.pushNamed(context, ConstantRoutes.report);
                        panelController.close();
                      },
                      bgColor: Colors.transparent,
                    ),
                  ),
                  const Divider(
                    height: 0.5,
                  ),
                  DefaultTextStyle(
                    style: TextThemes.normalTextButton,
                    child: CustomButton.normalButton(
                      context: context,
                      text: 'Salesman',
                      func: () {
                        context
                            .read<RouteBloc>()
                            .add(RoutePush(ConstantRoutes.sales));
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
      body: MultiBlocProvider(
        providers: StateManager.getHomeBlocProviders(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: FloatingActionButton(
            onPressed: () => panelController.open(),
            backgroundColor: ConstantColors.primaryColor1,
            child: const Icon(
              Icons.add,
              color: ConstantColors.primaryColor3,
            ),
          ),
          // ~:Profile Section:~
          appBar: AppBar(
            toolbarHeight: 100,
            elevation: 0.0,
            scrolledUnderElevation: 0.0,
            automaticallyImplyLeading: false,
            backgroundColor: ConstantColors.primaryColor1,
            title: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Wrap(
                spacing: 15,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  // ~:Profile Image:~
                  CircleAvatar(
                    backgroundColor: ConstantColors.primaryColor2,
                    radius: (MediaQuery.of(context).size.width < 800) ? 30 : 50,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        'assets/images/figma.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  // ~:Profile Name:~
                  Wrap(
                    direction: Axis.vertical,
                    children: [
                      // ~:Welcome Statement:~
                      const Text(
                        'Selamat datang,',
                        style: TextThemes.subtitle,
                      ),

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
              // ~:Logout Button:~
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LogoutSuccess) {
                      Navigator.pushReplacementNamed(context, '/welcome');
                    } else if (state is LogoutFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.getLogoutFailure),
                          backgroundColor: ConstantColors.primaryColor3,
                        ),
                      );
                    }
                  },
                  child: IconButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(LogoutButtonPressed());
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: ConstantColors.primaryColor3,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: DecoratedBox(
            decoration: const BoxDecoration(
              color: ConstantColors.primaryColor1,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: ConstantColors.primaryColor2,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    (MediaQuery.of(context).size.width < 800) ? 25 : 45,
                  ),
                  topRight: Radius.circular(
                    (MediaQuery.of(context).size.width < 800) ? 25 : 45,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: (MediaQuery.of(context).size.width < 800) ? 15 : 45,
                vertical: (MediaQuery.of(context).size.height < 800) ? 10 : 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ~:Filter Section:~
                  Filter.type1(context),

                  // ~:Divider:~
                  const SizedBox(height: 12),

                  // ~:Acts Section:~
                  Expanded(
                    child: BlocBuilder<FilterBloc, FilterState>(
                      builder: (context, state) {
                        if (state is FilterLoading) {
                          return Loading.platformIndicator(
                            iosRadius: 13,
                            iosCircleColor: ConstantColors.primaryColor3,
                            androidWidth: 28,
                            androidHeight: 28,
                            androidStrokeWidth: 3.5,
                            androidCircleColor: ConstantColors.primaryColor3,
                          );
                        } else if (state is FilterSuccess) {
                          final data = HomeModel(
                            briefingData: state.briefingData,
                            reportData: state.reportData,
                            salesData: state.salesData,
                          );

                          return SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runAlignment: WrapAlignment.center,
                              runSpacing: 10,
                              children: [
                                // ~:Briefing Section:~
                                Builder(builder: (context) {
                                  if (data.briefingData.isNotEmpty) {
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: ListView.builder(
                                        controller: scrollController,
                                        itemCount: data.briefingData.length,
                                        itemBuilder: (context, index) {
                                          final briefing =
                                              data.briefingData[index];

                                          return CustomCard.card(
                                            context,
                                            MediaQuery.of(context).size.width,
                                            Alignment.center,
                                            ConstantColors.primaryColor3,
                                            ConstantColors.primaryColor2,
                                            ConstantColors.shadowColor,
                                            const ClampingScrollPhysics(),
                                            borderWidth: 1.5,
                                            marginConfig: 0,
                                            [
                                              CustomCard.brief(
                                                context,
                                                'Lokasi',
                                                briefing.location,
                                                padHorizontal: 8,
                                              ),

                                              CustomCard.brief(
                                                context,
                                                'Peserta',
                                                '${briefing.participants} orang',
                                                padHorizontal: 8,
                                              ),

                                              CustomCard.brief(
                                                context,
                                                'Shop Manager',
                                                '${briefing.shopManager} orang',
                                                padHorizontal: 8,
                                              ),

                                              CustomCard.brief(
                                                context,
                                                'Sales Counter',
                                                '${briefing.salesCounter} orang',
                                                padHorizontal: 8,
                                              ),

                                              CustomCard.brief(
                                                context,
                                                'Salesman',
                                                '${briefing.salesman} orang',
                                                padHorizontal: 8,
                                              ),

                                              CustomCard.brief(
                                                context,
                                                'Others',
                                                '${briefing.others} orang',
                                                padHorizontal: 8,
                                              ),

                                              CustomCard.brief(
                                                context,
                                                'Description',
                                                briefing.topic,
                                                isHorizontal: false,
                                                padHorizontal: 8,
                                              ),

                                              // ~:Image:~
                                              CustomCard.button(
                                                context,
                                                () {},
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                30,
                                                Alignment.center,
                                                'Lihat Gambar',
                                                TextThemes.normal,
                                                ConstantColors.primaryColor1,
                                                8,
                                                8,
                                                20,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  }

                                  return const Center(
                                    child: Text('Briefing Data'),
                                  );
                                }),

                                // ~:Report Section:~
                                Builder(builder: (context) {
                                  if (data.reportData.isNotEmpty) {
                                    return const Center(
                                      child: Text('Report Data'),
                                    );
                                  }

                                  return const Center(
                                    child: Text('Report Data'),
                                  );
                                }),

                                // ~:Salesman Section:~
                                Builder(builder: (context) {
                                  if (data.salesData.isNotEmpty) {
                                    return const Center(
                                      child: Text('Sales Data'),
                                    );
                                  }

                                  return const Center(
                                    child: Text('Sales Data'),
                                  );
                                }),
                              ],
                            ),
                          );
                        } else if (state is FilterError) {
                          return Center(
                            child: Text(
                              state.errorMessage,
                              style: TextThemes.normal,
                              textAlign: TextAlign.center,
                            ),
                          );
                        }

                        return Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: const Text(
                            // state.activeFilter.toString(),
                            'No data available',
                            style: TextThemes.normal,
                            textAlign: TextAlign.center,
                          ),
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
    );
  }
}
