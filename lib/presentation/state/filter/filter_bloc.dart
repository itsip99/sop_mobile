import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/enum.dart';
import 'package:sop_mobile/presentation/state/filter/filter_event.dart';
import 'package:sop_mobile/presentation/state/filter/filter_state.dart';

class FilterBloc<BaseEvent, BaseState> extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial(FilterType.briefing)) {
    on<SelectedFilter>(selectedFilterHandler);
    on<UnselectedFilter>(unselectedFilterHandler);
  }

  Future<void> selectedFilterHandler(
    SelectedFilter event,
    Emitter<FilterState> emit,
  ) async {
    emit(FilterSelected(
      // ...(state as FilterSelected).activeFilter,
      // event.selectedFilter,
      activeFilter: event.selectedFilter,
    ));
  }

  Future<void> unselectedFilterHandler(
    UnselectedFilter event,
    Emitter<FilterState> emit,
  ) async {
    emit(FilterUnselected(
      // ...(state as FilterUnselected).getNonactiveFilter,
      // event.unselectFilter,
      activeFilter: event.unselectFilter,
    ));
  }
}
