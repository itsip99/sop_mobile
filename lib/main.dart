import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/state_manager.dart';
import 'package:sop_mobile/routes.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.black,
  //   // Adjust for icon visibility
  //   statusBarBrightness: Brightness.light,
  // ));

  // --- FIX: Add these lines to enable edge-to-edge display ---
  // This tells the app to draw behind the status and navigation bars.
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // This makes the navigation bar transparent, so your app's content shows through.
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.transparent,
  //   systemNavigationBarDividerColor: Colors.transparent,
  // ));
  // --- End of Fix ---z

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

    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: MediaQuery(
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
            routes: ConstantRoutes.maps,
          ),
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
