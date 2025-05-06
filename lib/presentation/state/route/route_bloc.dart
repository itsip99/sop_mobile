import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/presentation/state/route/route_event.dart';
import 'package:sop_mobile/presentation/state/route/route_state.dart';

class RouteBloc<BaseEvent, BaseState> extends Bloc<RouteEvent, RouteState> {
  RouteBloc() : super(RouteInitial()) {
    on<RoutePush>(pushHandler);
    on<RoutePop>(popHandler);
  }

  Future<void> pushHandler(
    RoutePush event,
    Emitter<RouteState> emit,
  ) async {
    emit(RoutePushed(event.routeName, arguments: event.arguments));
  }

  Future<void> popHandler(
    RoutePop event,
    Emitter<RouteState> emit,
  ) async {
    emit(RoutePopped(event.routeName));
  }
}
