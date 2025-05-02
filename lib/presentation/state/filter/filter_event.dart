import 'package:sop_mobile/core/constant/enum.dart';
import 'package:sop_mobile/presentation/state/base_event.dart';

abstract class FilterEvent extends BaseEvent {}

class SelectedFilter extends FilterEvent {
  final FilterType selectedFilter;

  SelectedFilter(this.selectedFilter);
}

class UnselectedFilter extends FilterEvent {
  final FilterType unselectFilter;

  UnselectedFilter(this.unselectFilter);
}
