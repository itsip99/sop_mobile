import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/state_manager.dart';
import 'package:sop_mobile/presentation/screens/briefing_screen.dart';
import 'package:sop_mobile/presentation/screens/home_screen.dart';
import 'package:sop_mobile/presentation/screens/location_screen.dart';
import 'package:sop_mobile/presentation/screens/login_screen.dart';
import 'package:sop_mobile/presentation/screens/report_screen.dart';
import 'package:sop_mobile/presentation/screens/salesman_screen.dart';
import 'package:sop_mobile/presentation/screens/signup_screen.dart';
import 'package:sop_mobile/presentation/screens/splash_screen.dart';
import 'package:sop_mobile/presentation/screens/welcome_screen.dart';
import 'package:sop_mobile/routes.dart';

final navigatorKey = GlobalKey<NavigatorState>();

//091188
void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    // Adjust for icon visibility
    statusBarBrightness: Brightness.light,
  ));

  // runApp(
  //   ChangeNotifierProvider(
  //     create: (context) => StateManager(),
  //     child: const MyApp(),
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(1.0),
      ),
      child: MultiBlocProvider(
        providers: StateManager.getBlocProviders(),
        child: MaterialApp(
          title: 'SOP Mobile',
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          initialRoute: ConstantRoutes.init,
          routes: {
            ConstantRoutes.init: (context) => const SplashScreen(),
            ConstantRoutes.welcome: (context) => const WelcomeScreen(),
            ConstantRoutes.login: (context) => const LoginScreen(),
            ConstantRoutes.register: (context) => const SignupScreen(),
            ConstantRoutes.location: (context) => const LocationScreen(),
            ConstantRoutes.home: (context) => const HomeScreen(),
            ConstantRoutes.brief: (context) => const BriefingScreen(),
            ConstantRoutes.report: (context) => const ReportScreen(),
            ConstantRoutes.sales: (context) => const SalesmanScreen(),
          },
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        // PointerDeviceKind.mouse,
      };
}
