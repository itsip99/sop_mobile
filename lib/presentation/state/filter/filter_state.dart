import 'package:equatable/equatable.dart';
import 'package:sop_mobile/core/constant/enum.dart';
import 'package:sop_mobile/data/models/briefing.dart';
import 'package:sop_mobile/data/models/report.dart';
import 'package:sop_mobile/data/models/sales.dart';
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

class AddFilter extends FilterState {
  AddFilter() : super([]);
}

class RemoveFilter extends FilterState {
  RemoveFilter() : super([]);
}

// ~:NEW::~
class FilterLoading extends FilterState {
  FilterLoading(super.activeFilter); // retain active filter
}

class FilterSuccess extends FilterState {
  final List<BriefingModel> briefingData;
  final List<ReportModel> reportData;
  final List<SalesModel> salesData;

  FilterSuccess(
    super.activeFilter,
    this.briefingData,
    this.reportData,
    this.salesData,
  );
}

class FilterError extends FilterState {
  final String errorMessage;

  FilterError(super.activeFilter, this.errorMessage);
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
