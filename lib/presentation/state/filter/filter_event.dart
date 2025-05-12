import 'package:sop_mobile/core/constant/enum.dart';
import 'package:sop_mobile/presentation/state/base_event.dart';

abstract class FilterEvent extends BaseEvent {}

class FilterAdded extends FilterEvent {
  final FilterType selectedFilter;
  final String date;

  FilterAdded(this.selectedFilter, this.date);
}

class FilterRemoved extends FilterEvent {
  final FilterType unselectFilter;
  final String date;

  FilterRemoved(this.unselectFilter, this.date);
}

// ~:Modified Date Filter Event:~
class FilterModified extends FilterEvent {
  final String date;

  FilterModified(this.date);
}

// class LoadBriefData extends FilterEvent {
//   // final List<FilterType> selectedFilter;

//   LoadBriefData(/*this.selectedFilter*/);
// }

// class LoadReportData extends FilterEvent {
//   // final List<FilterType> selectedFilter;

//   LoadReportData(/*this.selectedFilter*/);
// }
