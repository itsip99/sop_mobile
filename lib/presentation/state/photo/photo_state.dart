import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sop_mobile/presentation/state/base_state.dart';

abstract class PhotoState extends BaseState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class PhotoInitial extends PhotoState {
  String get getPhotoInitial => '';
}

class PhotoLoading extends PhotoState {
  String get getPhotoLoading => '';
}

class PhotoPermissionGranted extends PhotoState {
  final PermissionStatus permissionStatus;

  PhotoPermissionGranted(this.permissionStatus);

  PermissionStatus get getPhotoPermission => permissionStatus;
}

class PhotoPermissionDenied extends PhotoState {
  final PermissionStatus permissionStatus;

  PhotoPermissionDenied(this.permissionStatus);

  PermissionStatus get getPhotoPermission => permissionStatus;
}

class PhotoPermissionError extends PhotoState {
  final String error;

  PhotoPermissionError(this.error);

  String get getError => error;
}

class PhotoUploadSuccess extends PhotoState {
  final String photoUrl;

  PhotoUploadSuccess(this.photoUrl);

  List<String> get getPhotoUploaded => [photoUrl];
}

class PhotoUploadFail extends PhotoState {
  final String error;

  PhotoUploadFail(this.error);

  String get getPhotoUploadFail => error;
}

class PhotoDeleteSuccess extends PhotoState {
  PhotoDeleteSuccess();
}

class PhotoDeleteFail extends PhotoState {
  final String error;

  PhotoDeleteFail(this.error);

  String get getPhotoDeleteFail => error;
}
