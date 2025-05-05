import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sop_mobile/presentation/screens/briefing_screen.dart';
import 'package:sop_mobile/presentation/screens/home_screen.dart';
import 'package:sop_mobile/presentation/state/carousel/carousel_bloc.dart';
import 'package:sop_mobile/presentation/state/filter/filter_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/provider.dart';
import 'package:sop_mobile/presentation/screens/location_screen.dart';
import 'package:sop_mobile/presentation/screens/login_screen.dart';
import 'package:sop_mobile/presentation/screens/signup_screen.dart';
import 'package:sop_mobile/presentation/screens/splash_screen.dart';
import 'package:sop_mobile/presentation/screens/welcome_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

//091188
void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    // Adjust for icon visibility
    statusBarBrightness: Brightness.light,
  ));

  runApp(
    ChangeNotifierProvider(
      create: (context) => StateManager(),
      child: const MyApp(),
    ),
  );
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
        providers: [
          BlocProvider<CarouselBloc>(
            create: (context) => CarouselBloc(),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(),
          ),
          BlocProvider<FilterBloc>(
            create: (context) => FilterBloc(),
          ),
        ],
        child: MaterialApp(
          title: 'SOP Mobile',
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          home: const SplashScreen(),
          routes: {
            '/welcome': (context) => const WelcomeScreen(),
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const SignupScreen(),
            '/location': (context) => const LocationScreen(),
            '/home': (context) => const HomeScreen(),
            '/brief': (context) => const BriefingScreen(),
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
