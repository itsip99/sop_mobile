import 'package:equatable/equatable.dart';
import 'package:sop_mobile/data/models/briefing.dart';
import 'package:sop_mobile/presentation/state/base_event.dart';

abstract class BriefEvent extends BaseEvent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class BriefCreation extends BriefEvent {
  final List<BriefingModel> briefData;

  BriefCreation(this.briefData);
}
