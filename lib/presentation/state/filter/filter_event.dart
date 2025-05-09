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

// class LoadBriefData extends FilterEvent {
//   // final List<FilterType> selectedFilter;

//   LoadBriefData(/*this.selectedFilter*/);
// }

// class LoadReportData extends FilterEvent {
//   // final List<FilterType> selectedFilter;

//   LoadReportData(/*this.selectedFilter*/);
// }
