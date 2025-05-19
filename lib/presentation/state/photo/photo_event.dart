import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sop_mobile/presentation/state/base_event.dart';

abstract class PhotoEvent extends BaseEvent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class InitPhotoEvent extends PhotoEvent {
  InitPhotoEvent();
}

class CheckCameraPermission extends PhotoEvent {
  final PermissionStatus permissionStatus;

  CheckCameraPermission(this.permissionStatus);
}

class RemovePhotoEvent extends PhotoEvent {
  // final String photoUrl;

  RemovePhotoEvent();
}

class UploadPhotoEvent extends PhotoEvent {
  UploadPhotoEvent();
}

class DeletePhotoEvent extends PhotoEvent {
  final String photoUrl;

  DeletePhotoEvent(this.photoUrl);
}
