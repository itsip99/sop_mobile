import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_event.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: ConstantColors.primaryColor1,
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            log('Data available');
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is LoginFailure) {
            log('No data available');
            Navigator.pushReplacementNamed(context, '/welcome');
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: ConstantColors.primaryColor1,
          child: Wrap(
            direction: Axis.vertical,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              Image.asset(
                'assets/images/figma.png',
                scale: 0.8,
                width: 200,
                height: 200,
              ),
              Builder(
                builder: (context) {
                  if (Platform.isIOS) {
                    return const CupertinoActivityIndicator(
                      radius: 13,
                    );
                  } else {
                    return const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.5,
                        color: Colors.black,
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
