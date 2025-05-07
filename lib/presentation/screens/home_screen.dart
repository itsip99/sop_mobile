import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/presentation/state/filter/filter_bloc.dart';
import 'package:sop_mobile/presentation/state/filter/filter_event.dart';
import 'package:sop_mobile/presentation/state/filter/filter_state.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_event.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';
import 'package:sop_mobile/presentation/state/route/route_bloc.dart';
import 'package:sop_mobile/presentation/state/route/route_event.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/buttons.dart';
import 'package:sop_mobile/presentation/widgets/filter.dart';
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
      panel: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey[350],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
      body: Scaffold(
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
          // actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
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
              children: [
                // ~:Filter Section:~
                Filter.type1(context),

                // ~:Acts Section:~
                Expanded(
                  child: BlocBuilder<FilterBloc, FilterState>(
                    builder: (context, state) {
                      context
                          .read<FilterBloc>()
                          .add(LoadFilterData(state.activeFilter));

                      if (state is FilterLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is FilterSuccess) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: BlocBuilder<FilterBloc, FilterState>(
                            builder: (context, state) {
                              return const Text(
                                'Success',
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        );
                      } else if (state is FilterError) {
                        return Center(
                          child: Text(state.errorMessage),
                        );
                      }

                      return const Center(
                        child: Text('Something went wrong!'),
                      );
                    },
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
