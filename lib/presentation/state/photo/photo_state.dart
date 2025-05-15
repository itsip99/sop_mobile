import 'package:equatable/equatable.dart';
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
