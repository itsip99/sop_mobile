import 'package:sop_mobile/presentation/state/base_event.dart';

abstract class RouteEvent extends BaseEvent {}

class RoutePush extends RouteEvent {
  final String routeName;
  final Map<String, dynamic>? arguments;

  RoutePush(this.routeName, {this.arguments});
}

class RoutePop extends RouteEvent {
  final String routeName;

  RoutePop(this.routeName);
}
