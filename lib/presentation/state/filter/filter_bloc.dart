import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/data/models/briefing.dart';
import 'package:sop_mobile/data/repositories/filter.dart';
import 'package:sop_mobile/data/repositories/storage.dart';
import 'package:sop_mobile/presentation/state/filter/filter_event.dart';
import 'package:sop_mobile/presentation/state/filter/filter_state.dart';

class FilterBloc<BaseEvent, BaseState> extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial()) {
    on<FilterAdded>(addFilterHandler);
    on<FilterRemoved>(removeFilterHandler);
    on<LoadFilterData>(fetchDataHandler);
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

  Future<void> fetchDataHandler(
    LoadFilterData event,
    Emitter<FilterState> emit,
  ) async {
    emit(FilterLoading());
    try {
      // Simulate a network call or data fetching
      List<String> userCredentials =
          await StorageRepoImp().getUserCredentials();

      if (userCredentials[0] != '') {
        Map<String, dynamic> filterData = await FilterRepoImp().fetchData(
          userCredentials[0],
          '2025-05-05',
        );

        if (filterData['status'] == 'success') {
          // Emit success state with user data
          emit(FilterSuccess(filterData['data'] as List<BriefingModel>));
        } else {
          // Emit failure state with an error message
          emit(FilterError('Failed to fetch data'));
        }
      } else {
        emit(FilterError("User credentials are empty"));
      }
    } catch (e) {
      emit(FilterError(e.toString()));
    }
  }
}
