import 'package:flutter_bloc/flutter_bloc.dart';
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
      await Future.delayed(const Duration(seconds: 2));

      // ~:Unit Test Passed:~
      // Fake Repo Source Code...

      emit(BriefLoadSuccess(event.briefData));
    } catch (e) {
      emit(BriefLoadFail(e.toString()));
    }
  }
}
