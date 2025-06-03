import 'package:sop_mobile/presentation/state/base_event.dart';

abstract class LeasingEvent extends BaseEvent {}

class ResetLeasingData extends LeasingEvent {
  ResetLeasingData();
}

class LeasingDataAdded extends LeasingEvent {
  LeasingDataAdded();
}
