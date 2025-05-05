import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/presentation/state/filter/filter_bloc.dart';
import 'package:sop_mobile/presentation/state/filter/filter_state.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_event.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/filter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SlidingUpPanelController panelController = SlidingUpPanelController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    log('Width: ${MediaQuery.of(context).size.width}');
    log('Height: ${MediaQuery.of(context).size.height}');

    return Stack(
      children: [
        // ~:Main Body:~
        Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              panelController.anchor();
            },
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
            actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
            title: Wrap(
              spacing: 10,
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
            // ~:Utility Section:~
            actions: [
              // ~:Logout Button:~
              BlocListener<LoginBloc, LoginState>(
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
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Text(state.activeFilter.toString()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // ~:Sliding Up Panel:~
        SlidingUpPanelWidget(
          controlHeight: 50.0,
          anchor: 0.4,
          panelController: panelController,
          panelStatus: SlidingUpPanelStatus.hidden,
          onTap: () {
            ///Customize the processing logic
            if (SlidingUpPanelStatus.anchored == panelController.status) {
              panelController.hide();
            } else {
              panelController.anchor();
            }
          },
          //Pass a onTap callback to customize the processing logic when user click control bar.
          enableOnTap: true, //Enable the onTap callback for control bar.
          dragDown: (details) {
            log('dragDown');
          },
          dragStart: (details) {
            log('dragStart');
          },
          dragCancel: () {
            log('dragCancel');
          },
          dragUpdate: (details) {
            log('dragUpdate,${panelController.status == SlidingUpPanelStatus.dragging ? 'dragging' : ''}');
          },
          dragEnd: (details) {
            log('dragEnd');
          },
          child: Container(
            // margin: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: const ShapeDecoration(
              color: Colors.white,
              shadows: [
                BoxShadow(
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                  color: Color(0x11000000),
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  height: 50.0,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.menu,
                        size: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 8.0,
                        ),
                      ),
                      Text(
                        'click or drag',
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 0.5,
                  color: Colors.grey[300],
                ),
                Flexible(
                  child: Container(
                    color: Colors.white,
                    child: ListView.separated(
                      controller: scrollController,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return GestureDetector(
                            onTap: () {
                              // Navigate to the Briefing Screen
                              Navigator.pushNamed(context, '/brief');

                              // Hide sliding panel when navigating to another screen
                              panelController.hide();
                            },
                            child: const ListTile(
                              title: Text('Go to Briefing Screen'),
                            ),
                          );
                        } else {
                          return ListTile(
                            title: Text('list item $index'),
                          );
                        }
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 0.5,
                        );
                      },
                      shrinkWrap: true,
                      itemCount: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
