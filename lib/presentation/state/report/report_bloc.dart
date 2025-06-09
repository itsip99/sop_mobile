import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/data/models/user.dart';
import 'package:sop_mobile/data/repositories/storage.dart';
import 'package:sop_mobile/presentation/state/report/report_event.dart';
import 'package:sop_mobile/presentation/state/report/report_state.dart';

class ReportBloc<BaseEvent, BaseState> extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportInitial('initiated')) {
    on<CreateReport>(onCreateReport);
  }

  Future<void> onCreateReport(
    CreateReport event,
    Emitter<ReportState> emit,
  ) async {
    // Handle the creation of the report here
    // You can access event properties like event.dealerName, event.areaName, etc.
    // and update the state accordingly.

    // ~:Secure Storage Simulation:~
    UserCredsModel userCredentials =
        await StorageRepoImp().getUserCredentials();

    // Example: Emit a new state after creating the report
    emit(ReportCreationSuccess('success'));
  }
}
