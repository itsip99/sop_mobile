import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sop_mobile/domain/repositories/login.dart';
import 'package:sop_mobile/domain/repositories/storage.dart';
import 'package:sop_mobile/presentation/state/carousel/carousel_bloc.dart';
import 'package:sop_mobile/presentation/state/counter/counter_cubit.dart';
import 'package:sop_mobile/presentation/state/date/date_cubit.dart';
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
        create: (context) => LoginBloc(
          loginRepo: context.read<LoginRepo>(),
          storageRepo: context.read<StorageRepo>(),
        ),
      ),
      BlocProvider<CounterCubit>(
        create: (context) => CounterCubit(),
      ),
      BlocProvider<FilterBloc>(
        create: (context) => FilterBloc(),
      ),
    ];
  }

  static List<SingleChildWidget> getHomeBlocProviders() {
    return [
      BlocProvider<DateCubit>(
        create: (context) => DateCubit(),
      ),
    ];
  }
}
