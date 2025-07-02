// import 'package:equatable/equatable.dart';
// import 'package:sop_mobile/presentation/state/base_state.dart';

// abstract class PermissionState extends BaseState with EquatableMixin {
//   @override
//   List<Object?> get props => [];
// }

// class PermissionInitial extends PermissionState {
//   final bool cameraPermission;
//   final bool storagePermission;
//   final bool locationPermission;

//   PermissionInitial({
//     this.cameraPermission = false,
//     this.storagePermission = false,
//     this.locationPermission = false,
//   });
// }

// class PermissionLoading extends PermissionState {
//   String get getPermissionLoading => '';
// }

// class PermissionGranted extends PermissionState {
//   PermissionGranted();
// }

// class PermissionDenied extends PermissionState {
//   final String error;

//   PermissionDenied(this.error);
// }
