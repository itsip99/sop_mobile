import 'package:equatable/equatable.dart';
import 'package:sop_mobile/presentation/state/base_event.dart';

abstract class PhotoEvent extends BaseEvent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class UploadPhotoEvent extends PhotoEvent {
  UploadPhotoEvent();
}

class DeletePhotoEvent extends PhotoEvent {
  final String photoUrl;

  DeletePhotoEvent(this.photoUrl);
}
