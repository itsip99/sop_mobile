import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sop_mobile/data/repositories/login.dart';
import 'package:sop_mobile/data/repositories/report.dart';
import 'package:sop_mobile/data/repositories/sales.dart';
import 'package:sop_mobile/data/repositories/storage.dart';
import 'package:sop_mobile/presentation/screens/report_screen.dart';
import 'package:sop_mobile/presentation/state/brief/brief_bloc.dart';
import 'package:sop_mobile/presentation/state/carousel/carousel_bloc.dart';
import 'package:sop_mobile/presentation/state/counter/counter_cubit.dart';
import 'package:sop_mobile/presentation/state/cubit/sales_status.dart';
import 'package:sop_mobile/presentation/state/import/import_bloc.dart';
import 'package:sop_mobile/presentation/state/leasing/leasing_bloc.dart';
import 'package:sop_mobile/presentation/state/cubit/sales_position.dart';
import 'package:sop_mobile/presentation/state/date/date_cubit.dart';
import 'package:sop_mobile/presentation/state/filter/filter_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/payment/payment_bloc.dart';
import 'package:sop_mobile/presentation/state/permission/camera_cubit.dart';
import 'package:sop_mobile/presentation/state/permission/storage_cubit.dart';
import 'package:sop_mobile/presentation/state/photo/photo_bloc.dart';
import 'package:sop_mobile/presentation/state/report/report_bloc.dart';
import 'package:sop_mobile/presentation/state/route/route_bloc.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_bloc.dart';
import 'package:sop_mobile/presentation/state/stu/stu_bloc.dart';

class StateManager {
  static List<SingleChildWidget> getBlocProviders() {
    return [
      BlocProvider<RouteBloc>(create: (context) => RouteBloc()),
      BlocProvider<CarouselBloc>(create: (context) => CarouselBloc()),
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(LoginRepoImp(), StorageRepoImp()),
      ),
      BlocProvider<CounterCubit>(create: (context) => CounterCubit()),
      BlocProvider<FilterBloc>(create: (context) => FilterBloc()),
      BlocProvider<DateCubit>(create: (context) => DateCubit()),
      BlocProvider<BriefBloc>(create: (context) => BriefBloc()),
      BlocProvider<SalesmanBloc>(
        create:
            (context) => SalesmanBloc(
              salesRepo: SalesRepoImp(),
              storageRepo: StorageRepoImp(),
            ),
      ),
      // BlocProvider<PermissionBloc>(
      //   create: (context) => PermissionBloc(),
      // ),
      BlocProvider<CameraCubit>(create: (context) => CameraCubit()),
      BlocProvider<StorageCubit>(create: (context) => StorageCubit()),
      BlocProvider<PhotoBloc>(create: (context) => PhotoBloc()),
      BlocProvider<ImportBloc>(create: (context) => ImportBloc()),
      BlocProvider<SalesPositionCubit>(
        create: (context) => SalesPositionCubit(),
      ),
      BlocProvider<SalesStatusCubit>(create: (context) => SalesStatusCubit()),
      BlocProvider<StuBloc>(
        create: (context) => StuBloc(),
        child: const ReportScreen(),
      ),
      BlocProvider<PaymentBloc>(
        create: (context) => PaymentBloc(),
        child: const ReportScreen(),
      ),
      BlocProvider<LeasingBloc>(
        create: (context) => LeasingBloc(),
        child: const ReportScreen(),
      ),
      BlocProvider<ReportBloc>(
        create:
            (context) => ReportBloc(
              reportRepo: ReportRepoImp(),
              storageRepo: StorageRepoImp(),
            ),
        child: const ReportScreen(),
      ),
    ];
  }
}
