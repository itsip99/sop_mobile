import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/data/repositories/brief.dart';
import 'package:sop_mobile/presentation/state/brief/brief_event.dart';
import 'package:sop_mobile/presentation/state/brief/brief_state.dart';

class BriefBloc<BaseEvent, BaseState> extends Bloc<BriefEvent, BriefState> {
  BriefBloc() : super(BriefInitial()) {
    on<BriefCreation>(createBriefReport);
  }

  Future<void> createBriefReport(
    BriefCreation event,
    Emitter<BriefState> emit,
  ) async {
    emit(BriefLoading());
    try {
      // Simulate a network call
      Map<String, dynamic> user = await BriefRepoImp().createBriefingReport(
        event.username,
        event.branch,
        event.shop,
        event.date,
        event.location,
        event.participants,
        event.manager,
        event.counter,
        event.sales,
        event.other,
        event.desc,
        event.img,
      );

      // ~:Unit Test Passed:~
      // Fake Repo Source Code...

      if (user['status'] == 'success') {
        // ~:Emit success state with user data:~
        emit(BriefCreationSuccess(user['data']));
      } else {
        // ~:Emit failure state with an error message:~
        emit(BriefCreationFail(user['data']));
      }
    } catch (e) {
      emit(BriefCreationFail(e.toString()));
    }
  }
}
