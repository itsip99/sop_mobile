import 'package:equatable/equatable.dart';
import 'package:sop_mobile/core/constant/enum.dart';
import 'package:sop_mobile/presentation/state/base_state.dart';

class FilterState extends BaseState with EquatableMixin {
  final List<FilterType> activeFilter;

  FilterState(this.activeFilter);

  @override
  List<Object?> get props => [activeFilter];
}

class FilterInitial extends FilterState {
  FilterInitial() : super([]);

  // FilterType get getFilterInitial => activeFilter;
}

// class FilterSelected extends FilterState {
//   // final FilterType selectedFilter;

//   FilterSelected(/*this.selectedFilter,*/ {
//     required activeFilter,
//   }) : super(activeFilter);

//   // FilterType get getSelectedFilter => selectedFilter;
// }

// class FilterUnselected extends FilterState {
//   // final FilterType unselectedFilter;

//   FilterUnselected(/*this.unselectedFilter,*/ {
//     required activeFilter,
//   }) : super(activeFilter);

//   // FilterType get getUnselectedFilter => unselectedFilter;
// }
