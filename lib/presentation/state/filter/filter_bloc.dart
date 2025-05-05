import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/presentation/state/filter/filter_event.dart';
import 'package:sop_mobile/presentation/state/filter/filter_state.dart';

class FilterBloc<BaseEvent, BaseState> extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial()) {
    on<FilterAdded>(addFilterHandler);
    on<FilterRemoved>(removeFilterHandler);
  }

  Future<void> addFilterHandler(
    FilterAdded event,
    Emitter<FilterState> emit,
  ) async {
    final currentFilter = state.activeFilter;
    if (!currentFilter.contains(event.selectedFilter)) {
      emit(FilterState([...currentFilter, event.selectedFilter]));
    }
  }

  Future<void> removeFilterHandler(
    FilterRemoved event,
    Emitter<FilterState> emit,
  ) async {
    final currentFilter = state.activeFilter;
    emit(FilterState(
      currentFilter.where((e) => e != event.unselectFilter).toList(),
    ));
  }
}
