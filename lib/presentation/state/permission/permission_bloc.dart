// import 'dart:developer';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sop_mobile/presentation/state/permission/permission_event.dart';
// import 'package:sop_mobile/presentation/state/permission/permission_state.dart';
// import 'package:permission_handler/permission_handler.dart';

// class PermissionBloc<BaseEvent, BaseState>
//     extends Bloc<PermissionEvent, PermissionState> {
//   PermissionBloc() : super(PermissionInitial()) {
//     on<AskCameraPermit>(cameraPermitHandler);
//     on<AskStoragePermit>(storagePermitHandler);
//     on<AskLocationPermit>(locationPermitHandler);
//   }

//   Future<void> cameraPermitHandler(
//     AskCameraPermit event,
//     Emitter<PermissionState> emit,
//   ) async {
//     emit(PermissionLoading());
//     try {
//       final PermissionStatus status = await Permission.camera.status;
//       if (status.isDenied) {
//         // Simulate a network call
//         final PermissionStatus result = await Permission.camera.request();

//         if (result.isGranted) {
//           log('Permission granted');
//           // ~:Permission granted:~
//           emit(PermissionInitial(cameraPermission: true));
//           emit(PermissionGranted());
//         } else {
//           log('Permission denied');
//           // ~:Permission denied:~
//           emit(PermissionInitial(cameraPermission: false));
//           emit(PermissionDenied('Permission denied'));
//         }
//       } else {
//         log('Permission already granted');
//         emit(PermissionInitial(cameraPermission: true));
//         emit(PermissionGranted());
//       }

//       // ~:Unit Test Passed:~
//       // Fake Repo Source Code...
//     } catch (e) {
//       log('Permission Error: ${e.toString()}');
//       emit(PermissionInitial(cameraPermission: false));
//       emit(PermissionDenied(e.toString()));
//     }
//   }

//   Future<void> storagePermitHandler(
//     AskStoragePermit event,
//     Emitter<PermissionState> emit,
//   ) async {
//     emit(PermissionLoading());
//     try {
//       final PermissionStatus status = await Permission.storage.status;
//       if (status.isDenied) {
//         // Simulate a network call
//         final PermissionStatus result = await Permission.storage.request();

//         if (result.isGranted) {
//           log('Storage permission granted');
//           // ~:Permission granted:~
//           emit(PermissionInitial(storagePermission: true));
//           emit(PermissionGranted());
//         } else {
//           log('Storage permission denied');
//           // ~:Permission denied:~
//           emit(PermissionInitial(storagePermission: false));
//           emit(PermissionDenied('Permission denied'));
//         }
//       } else {
//         log('Storage permission already granted');
//         emit(PermissionInitial(storagePermission: true));
//         emit(PermissionGranted());
//       }
//     } catch (e) {
//       log('Storage permission Error: ${e.toString()}');
//       emit(PermissionInitial(storagePermission: false));
//       emit(PermissionDenied(e.toString()));
//     }
//   }

//   Future<void> locationPermitHandler(
//     AskLocationPermit event,
//     Emitter<PermissionState> emit,
//   ) async {
//     emit(PermissionLoading());
//     try {
//       final PermissionStatus status = await Permission.location.status;
//       if (status.isDenied) {
//         // Simulate a network call
//         final PermissionStatus result = await Permission.location.request();

//         if (result.isGranted) {
//           log('Location permission granted');
//           // ~:Permission granted:~
//           emit(PermissionInitial(locationPermission: true));
//           emit(PermissionGranted());
//         } else {
//           log('Location permission denied');
//           // ~:Permission denied:~
//           emit(PermissionInitial(locationPermission: false));
//           emit(PermissionDenied('Permission denied'));
//         }
//       } else {
//         log('Location permission already granted');
//         emit(PermissionInitial(locationPermission: true));
//         emit(PermissionGranted());
//       }
//     } catch (e) {
//       log('Location permission Error: ${e.toString()}');
//       emit(PermissionInitial(locationPermission: false));
//       emit(PermissionDenied(e.toString()));
//     }
//   }
// }
