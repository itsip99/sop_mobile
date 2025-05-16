import 'package:equatable/equatable.dart';
import 'package:sop_mobile/presentation/state/base_event.dart';

abstract class PermissionEvent extends BaseEvent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class AskCameraPermit extends PermissionEvent {
  AskCameraPermit();
}
