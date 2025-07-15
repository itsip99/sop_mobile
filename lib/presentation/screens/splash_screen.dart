import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/core/constant/enum.dart';
import 'package:sop_mobile/presentation/state/filter/filter_bloc.dart';
import 'package:sop_mobile/presentation/state/filter/filter_event.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_event.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';
import 'package:sop_mobile/presentation/state/route/route_bloc.dart';
import 'package:sop_mobile/presentation/state/route/route_event.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/loading.dart';
import 'package:sop_mobile/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void preprocessing() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    if (mounted) Navigator.pushReplacementNamed(context, '/welcome');
  }

  @override
  void initState() {
    super.initState();

    // preprocessing();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Dispatch LoadUserData after the first frame
      context.read<LoginBloc>().add(LoginButtonPressed());
      if (LoginState is LoginSuccess) {
        context.read<RouteBloc>().add(RoutePush(ConstantRoutes.home));
      } else {
        context.read<RouteBloc>().add(RoutePush(ConstantRoutes.welcome));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: ConstantColors.primaryColor2,
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            log('Data available');
            context.read<FilterBloc>().add(
              FilterAdded(
                FilterType.briefing,
                DateTime.now().toString().split(' ')[0],
              ),
            );
            Navigator.pushReplacementNamed(context, ConstantRoutes.home);
          } else if (state is LoginFailure) {
            log('No data available');
            Navigator.pushReplacementNamed(context, ConstantRoutes.welcome);
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: ConstantColors.primaryColor2,
          child: Column(
            children: [
              // ~:Logo:~
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      scale: 0.8,
                      width: 175,
                      height: 175,
                    ),
                    Builder(
                      builder: (context) {
                        return Loading.platformIndicator(
                          iosRadius: 13,
                          iosCircleColor: ConstantColors.primaryColor3,
                          androidWidth: 28,
                          androidHeight: 28,
                          androidStrokeWidth: 3.5,
                          androidCircleColor: ConstantColors.primaryColor3,
                        );
                      },
                    ),
                  ],
                ),
              ),

              // ~:Version:~
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('Version 1.0.0', style: TextThemes.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
