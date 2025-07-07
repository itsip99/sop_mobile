import 'package:flutter/widgets.dart';
import 'package:sop_mobile/presentation/screens/settings_screen.dart';
import 'package:sop_mobile/presentation/screens/briefing_screen.dart';
import 'package:sop_mobile/presentation/screens/home_screen.dart';
import 'package:sop_mobile/presentation/screens/location_screen.dart';
import 'package:sop_mobile/presentation/screens/login_screen.dart';
import 'package:sop_mobile/presentation/screens/report_screen.dart';
import 'package:sop_mobile/presentation/screens/salesman_screen.dart';
import 'package:sop_mobile/presentation/screens/signup_screen.dart';
import 'package:sop_mobile/presentation/screens/splash_screen.dart';
import 'package:sop_mobile/presentation/screens/welcome_screen.dart';

class ConstantRoutes {
  static const String init = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String location = '/location';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String brief = '/brief';
  static const String report = '/report';
  static const String sales = '/sales';
  static const String about = '/about';

  static Map<String, Widget Function(BuildContext)> maps = {
    ConstantRoutes.init: (context) => const SplashScreen(),
    ConstantRoutes.welcome: (context) => const WelcomeScreen(),
    ConstantRoutes.login: (context) => const LoginScreen(),
    ConstantRoutes.register: (context) => const SignupScreen(),
    ConstantRoutes.location: (context) => const LocationScreen(),
    ConstantRoutes.home: (context) => const HomeScreen(),
    ConstantRoutes.settings: (context) => const SettingsScreen(),
    ConstantRoutes.brief: (context) => const BriefingScreen(),
    ConstantRoutes.report: (context) => const ReportScreen(),
    ConstantRoutes.sales: (context) => const SalesmanScreen(),
  };

  // final Map<String, WidgetBuilder> routes = {
  //   '/': (context) => const SplashScreen(),
  //   '/welcome': (context) => const WelcomeScreen(),
  //   '/login': (context) => const LoginScreen(),
  //   '/register': (context) => const SignupScreen(),
  //   '/location': (context) => const LocationScreen(),
  //   '/home': (context) => const HomeScreen(),
  //   '/brief': (context) => const BriefingScreen(),
  // };
}
