import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/presentation/state/permission/permission_event.dart';
import 'package:sop_mobile/presentation/state/permission/permission_state.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionBloc<BaseEvent, BaseState>
    extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitial()) {
    on<AskCameraPermit>(cameraPermitHandler);
  }

  Future<void> cameraPermitHandler(
    AskCameraPermit event,
    Emitter<PermissionState> emit,
  ) async {
    emit(PermissionLoading());
    try {
      final PermissionStatus status = await Permission.camera.status;
      if (status.isDenied) {
        // Simulate a network call
        final PermissionStatus result = await Permission.camera.request();

        if (result.isGranted) {
          log('Permission granted');
          // ~:Permission granted:~
          emit(PermissionInitial(cameraPermission: true));
          emit(PermissionGranted());
        } else {
          log('Permission denied');
          // ~:Permission denied:~
          emit(PermissionInitial(cameraPermission: false));
          emit(PermissionDenied('Permission denied'));
        }
      } else {
        log('Permission already granted');
        emit(PermissionInitial(cameraPermission: true));
        emit(PermissionGranted());
      }

      // ~:Unit Test Passed:~
      // Fake Repo Source Code...
    } catch (e) {
      log('Permission Error: ${e.toString()}');
      emit(PermissionInitial(cameraPermission: false));
      emit(PermissionDenied(e.toString()));
    }
  }
}
