import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/data/repositories/brief.dart';
import 'package:sop_mobile/domain/repositories/brief.dart';
import 'package:sop_mobile/presentation/state/brief/brief_event.dart';
import 'package:sop_mobile/presentation/state/brief/brief_state.dart';

class BriefBloc<BaseEvent, BaseState> extends Bloc<BriefEvent, BriefState> {
  final BriefRepo briefRepo;

  BriefBloc({BriefRepo? briefRepo})
    : briefRepo = briefRepo ?? BriefRepoImp(),
      super(BriefInitial()) {
    on<BriefCreation>(createBriefReport);
    on<BriefImageRetrieval>(retrieveBriefImage);
  }

  Future<void> createBriefReport(
    BriefCreation event,
    Emitter<BriefState> emit,
  ) async {
    emit(BriefLoading());
    try {
      if (event.location.isNotEmpty &&
          event.desc.isNotEmpty &&
          event.img.isNotEmpty) {
        // Simulate a network call
        Map<String, dynamic> user = await briefRepo.createBriefingReport(
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
      } else {
        List<String> errors = [];
        if (event.location.isEmpty) {
          errors.add('Location');
        }
        if (event.desc.isEmpty) {
          errors.add('Description');
        }
        if (event.img.isEmpty) {
          errors.add('Image');
        }

        if (errors.length == 1) {
          emit(BriefCreationFail('${errors[0]} is required.'));
        } else {
          emit(
            BriefCreationFail(
              '${errors.asMap().entries.map((e) {
                final i = e.key;
                final v = e.value;

                return i == 0 ? v : v.toLowerCase();
              }).join(', ')} are required',
            ),
          );
        }
      }
    } catch (e) {
      emit(BriefCreationFail(e.toString()));
    }
  }

  Future<void> retrieveBriefImage(
    BriefImageRetrieval event,
    Emitter<BriefState> emit,
  ) async {
    emit(BriefImageLoading());
    try {
      Map<String, dynamic> user = await briefRepo.retrieveBriefImage(
        event.userId,
        event.date,
      );

      if (user['status'] == 'success') {
        // ~:Emit success state with user data:~
        emit(BriefImageRetrievalSuccess(user['data']));
      } else {
        // ~:Emit failure state with an error message:~
        emit(BriefImageRetrievalFail(user['data']));
      }
    } catch (e) {
      emit(BriefImageRetrievalFail(e.toString()));
    }
  }
}
