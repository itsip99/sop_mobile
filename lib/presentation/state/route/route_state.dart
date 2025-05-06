import 'package:equatable/equatable.dart';
import 'package:sop_mobile/presentation/state/base_state.dart';

abstract class RouteState extends BaseState with EquatableMixin {}

class RouteInitial extends RouteState {
  @override
  List<Object?> get props => [];
}

class RoutePushed extends RouteState {
  final String routeName;
  final Map<String, dynamic>? arguments;

  RoutePushed(this.routeName, {this.arguments});

  @override
  List<Object?> get props => [routeName, arguments];
}

class RoutePopped extends RouteState {
  final String routeName;

  RoutePopped(this.routeName);

  @override
  List<Object?> get props => [routeName];
}
