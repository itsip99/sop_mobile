import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/data/models/briefing.dart';
import 'package:sop_mobile/data/models/user.dart';
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
    emit(FilterLoading());
    emit(FilterState([...currentFilter, event.selectedFilter]));
    emit(AddFilter());
    // if (!currentFilter.contains(event.selectedFilter)) {
    //   emit(FilterLoading());
    //   emit(FilterState([...currentFilter, event.selectedFilter]));
    // }
  }

  Future<void> removeFilterHandler(
    FilterRemoved event,
    Emitter<FilterState> emit,
  ) async {
    final currentFilter = state.activeFilter;
    emit(FilterLoading());
    emit(FilterState(
      currentFilter.where((e) => e != event.unselectFilter).toList(),
    ));
    emit(RemoveFilter());
  }

  Future<void> fetchDataHandler(
    LoadFilterData event,
    Emitter<FilterState> emit,
  ) async {
    emit(FilterLoading());
    try {
      // Simulate a network call or data fetching
      UserCredsModel userCredentials =
          await StorageRepoImp().getUserCredentials();

      if (userCredentials.username != '') {
        log('Username: ${userCredentials.username}');
        Map<String, dynamic> filterData = await FilterRepoImp()
            .fetchBriefingData(userCredentials.username, '2025-05-05');

        if (filterData['status'] == 'success') {
          log('Data fetched successfully');
          // Emit success state with user data
          emit(FilterSuccess(filterData['data'] as List<BriefingModel>));
        } else {
          log('Data fetch failed');
          // Emit failure state with an error message
          emit(FilterError('Failed to fetch data'));
        }
      } else {
        log('Username is empty');
        emit(FilterError("User credentials are empty"));
      }
    } catch (e) {
      log('Error!');
      emit(FilterError(e.toString()));
    }
  }
}
