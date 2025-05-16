import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sop_mobile/presentation/state/brief/brief_bloc.dart';
import 'package:sop_mobile/presentation/state/carousel/carousel_bloc.dart';
import 'package:sop_mobile/presentation/state/counter/counter_cubit.dart';
import 'package:sop_mobile/presentation/state/date/date_cubit.dart';
import 'package:sop_mobile/presentation/state/filter/filter_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/permission/camera_cubit.dart';
import 'package:sop_mobile/presentation/state/permission/permission_bloc.dart';
import 'package:sop_mobile/presentation/state/photo/photo_bloc.dart';
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
      BlocProvider<CounterCubit>(
        create: (context) => CounterCubit(),
      ),
      BlocProvider<FilterBloc>(
        create: (context) => FilterBloc(),
      ),
      BlocProvider<BriefBloc>(
        create: (context) => BriefBloc(),
      ),
      BlocProvider<PermissionBloc>(
        create: (context) => PermissionBloc(),
      ),
      BlocProvider<CameraCubit>(
        create: (context) => CameraCubit(),
      ),
      BlocProvider<PhotoBloc>(
        create: (context) => PhotoBloc(),
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

  static List<SingleChildWidget> getBriefBlocProviders() {
    return [];
  }
}
