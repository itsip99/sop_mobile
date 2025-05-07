import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sop_mobile/presentation/state/carousel/carousel_bloc.dart';
import 'package:sop_mobile/presentation/state/counter/counter_cubit.dart';
import 'package:sop_mobile/presentation/state/filter/filter_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/route/route_bloc.dart';

class StateManager {
  static List<SingleChildWidget> getBlocProviders() {
    return [
      BlocProvider<RouteBloc>(
        create: (context) => RouteBloc(),
      ),
      BlocProvider<CarouselBloc>(
        create: (context) => CarouselBloc(),
      ),
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
      ),
      BlocProvider<FilterBloc>(
        create: (context) => FilterBloc(),
      ),
      BlocProvider<CounterCubit>(
        create: (context) => CounterCubit(),
      ),
    ];
  }
}
