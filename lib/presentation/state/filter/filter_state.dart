import 'package:equatable/equatable.dart';
import 'package:sop_mobile/core/constant/enum.dart';
import 'package:sop_mobile/data/models/briefing.dart';
import 'package:sop_mobile/presentation/state/base_state.dart';

class FilterState extends BaseState with EquatableMixin {
  final List<FilterType> activeFilter;

  FilterState(this.activeFilter);

  @override
  List<Object?> get props => [activeFilter];
}

class FilterInitial extends FilterState {
  FilterInitial() : super([FilterType.briefing]);

  // FilterType get getFilterInitial => activeFilter;
}

// ~:NEW::~
class FilterLoading extends FilterState {
  FilterLoading() : super([FilterType.briefing]);
}

class FilterSuccess extends FilterState {
  final List<BriefingModel> data;

  FilterSuccess(this.data) : super([FilterType.briefing]);

  @override
  List<BriefingModel> get props => data;
}

class FilterError extends FilterState {
  final String errorMessage;

  FilterError(this.errorMessage) : super([FilterType.briefing]);

  @override
  List<String> get props => [errorMessage];
}
// ~:NEW::~

// class FilterSelected extends FilterState {
//   // final FilterType selectedFilter;
//
//   FilterSelected(/*this.selectedFilter,*/ {
//     required activeFilter,
//   }) : super(activeFilter);
//
//   // FilterType get getSelectedFilter => selectedFilter;
// }
//
// class FilterUnselected extends FilterState {
//   // final FilterType unselectedFilter;
//
//   FilterUnselected(/*this.unselectedFilter,*/ {
//     required activeFilter,
//   }) : super(activeFilter);
//
//   // FilterType get getUnselectedFilter => unselectedFilter;
// }
