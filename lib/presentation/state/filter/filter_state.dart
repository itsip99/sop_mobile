import 'package:equatable/equatable.dart';
import 'package:sop_mobile/core/constant/enum.dart';
import 'package:sop_mobile/presentation/state/base_state.dart';

abstract class FilterState extends BaseState with EquatableMixin {
  final FilterType activeFilter;

  FilterState(this.activeFilter);

  @override
  List<Object?> get props => [];
}

class FilterInitial extends FilterState {
  FilterInitial(super.activeFilter);

  List<int> get getFilterInitial => [0];
}

class FilterSelected extends FilterState {
  // final FilterType selectedFilter;

  FilterSelected(/*this.selectedFilter,*/ {
    required activeFilter,
  }) : super(activeFilter);

  // FilterType get getSelectedFilter => selectedFilter;
}

class FilterUnselected extends FilterState {
  // final FilterType unselectedFilter;

  FilterUnselected(/*this.unselectedFilter,*/ {
    required activeFilter,
  }) : super(activeFilter);

  // FilterType get getUnselectedFilter => unselectedFilter;
}
