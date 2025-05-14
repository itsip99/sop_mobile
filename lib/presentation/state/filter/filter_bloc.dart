import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/enum.dart';
import 'package:sop_mobile/data/models/home.dart';
import 'package:sop_mobile/data/repositories/filter.dart';
import 'package:sop_mobile/presentation/state/filter/filter_event.dart';
import 'package:sop_mobile/presentation/state/filter/filter_state.dart';

class FilterBloc<BaseEvent, BaseState> extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial()) {
    on<FilterAdded>(addFilterHandler);
    on<FilterRemoved>(removeFilterHandler);
    on<FilterModified>(modifyFilterHandler);
  }

  Future<void> addFilterHandler(
    FilterAdded event,
    Emitter<FilterState> emit,
  ) async {
    log('Handling ${event.selectedFilter}');
    if (!state.activeFilter.contains(event.selectedFilter)) {
      emit(FilterState([...state.activeFilter, event.selectedFilter]));
    }

    try {
      emit(FilterLoading(state.activeFilter));
      log('Data retrieval started');
      HomeModel res = await FilterRepoImp().dataPreprocessing(
        state.activeFilter.contains(FilterType.briefing),
        state.activeFilter.contains(FilterType.report),
        state.activeFilter.contains(FilterType.salesman),
        event.date,
      );

      if (res.briefingData.isNotEmpty ||
          res.reportData.isNotEmpty ||
          res.salesData.isNotEmpty) {
        log('Data retrieval completed');
        emit(FilterSuccess(
          state.activeFilter,
          res.briefingData,
          res.reportData,
          res.salesData,
        ));
      } else {
        log('No data available');
        emit(FilterError(state.activeFilter, 'No data available'));
      }
    } catch (e) {
      log('Error occurred: $e');
      emit(FilterError(state.activeFilter, e.toString()));
    }
  }

  Future<void> removeFilterHandler(
    FilterRemoved event,
    Emitter<FilterState> emit,
  ) async {
    emit(FilterState(
      state.activeFilter.where((e) => e != event.unselectFilter).toList(),
    ));

    try {
      log('Deactivate Filter: ${state.activeFilter}');
      emit(FilterLoading(state.activeFilter));
      HomeModel res = await FilterRepoImp().dataPreprocessing(
        state.activeFilter.contains(FilterType.briefing),
        state.activeFilter.contains(FilterType.report),
        state.activeFilter.contains(FilterType.salesman),
        event.date,
      );

      if (res.briefingData.isNotEmpty ||
          res.reportData.isNotEmpty ||
          res.salesData.isNotEmpty) {
        emit(FilterSuccess(
          state.activeFilter,
          res.briefingData,
          res.reportData,
          res.salesData,
        ));
      } else {
        emit(FilterError(state.activeFilter, 'No data available'));
      }
    } catch (e) {
      emit(FilterError(state.activeFilter, e.toString()));
    }
  }

  // ~:Modified Date Filter Handler:~
  Future<void> modifyFilterHandler(
    FilterModified event,
    Emitter<FilterState> emit,
  ) async {
    try {
      emit(FilterLoading(state.activeFilter));
      log('Data retrieval completed');
      HomeModel res = await FilterRepoImp().dataPreprocessing(
        state.activeFilter.contains(FilterType.briefing),
        state.activeFilter.contains(FilterType.report),
        state.activeFilter.contains(FilterType.salesman),
        event.date,
      );

      if (res.briefingData.isNotEmpty ||
          res.reportData.isNotEmpty ||
          res.salesData.isNotEmpty) {
        log('Data retrieval completed');
        emit(FilterSuccess(
          state.activeFilter,
          res.briefingData,
          res.reportData,
          res.salesData,
        ));
      } else {
        log('No data available');
        emit(FilterError(state.activeFilter, 'No data available'));
      }
    } catch (e) {
      log('Error occurred: $e');
      emit(FilterError(state.activeFilter, e.toString()));
    }
  }

  // Future<void> fetchDataHandler(
  //   LoadFilterData event,
  //   Emitter<FilterState> emit,
  // ) async {
  //   emit(FilterLoading());
  //   try {
  //     // Simulate a network call or data fetching
  //     UserCredsModel userCredentials =
  //         await StorageRepoImp().getUserCredentials();
  //
  //     if (userCredentials.username != '') {
  //       log('Username: ${userCredentials.username}');
  //       Map<String, dynamic> filterData = await FilterRepoImp()
  //           .fetchBriefingData(userCredentials.username, '2025-05-05');
  //
  //       if (filterData['status'] == 'success') {
  //         log('Data fetched successfully');
  //         // Emit success state with user data
  //         emit(FilterSuccess(filterData['data'] as List<BriefingModel>));
  //       } else {
  //         log('Data fetch failed');
  //         // Emit failure state with an error message
  //         emit(FilterError('Failed to fetch data'));
  //       }
  //     } else {
  //       log('Username is empty');
  //       emit(FilterError("User credentials are empty"));
  //     }
  //   } catch (e) {
  //     log('Error!');
  //     emit(FilterError(e.toString()));
  //   }
  // }
}
