import 'package:sop_mobile/core/constant/enum.dart';
import 'package:sop_mobile/presentation/state/base_event.dart';

abstract class FilterEvent extends BaseEvent {}

class FilterAdded extends FilterEvent {
  final FilterType selectedFilter;

  FilterAdded(this.selectedFilter);
}

class FilterRemoved extends FilterEvent {
  final FilterType unselectFilter;

  FilterRemoved(this.unselectFilter);
}
