import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/enum.dart';
import 'package:sop_mobile/data/models/briefing.dart';
import 'package:sop_mobile/data/models/home.dart';
import 'package:sop_mobile/data/repositories/filter.dart';
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
    log('Handling ${event.selectedFilter}');
    emit(FilterState([...state.activeFilter, event.selectedFilter]));

    List<BriefingModel> briefRes = [];
    List reportRes = [];
    List salesRes = [];
    try {
      emit(FilterLoading(state.activeFilter));
      HomeModel res = await FilterRepoImp().dataPreprocessing(
        state.activeFilter.contains(FilterType.briefing),
        state.activeFilter.contains(FilterType.report),
        state.activeFilter.contains(FilterType.salesman),
      );
      briefRes = res.briefingData;
      reportRes = res.reportData;
      salesRes = res.salesData;
    } catch (e) {
      emit(FilterError(state.activeFilter, e.toString()));
    }

    if (briefRes.isNotEmpty || reportRes.isNotEmpty || salesRes.isNotEmpty) {
      emit(FilterSuccess(state.activeFilter, briefRes, reportRes, salesRes));
    } else {
      emit(FilterError(state.activeFilter, 'No data available'));
    }
  }

  Future<void> removeFilterHandler(
    FilterRemoved event,
    Emitter<FilterState> emit,
  ) async {
    emit(FilterState(
      state.activeFilter.where((e) => e != event.unselectFilter).toList(),
    ));

    List<BriefingModel> briefRes = [];
    List reportRes = [];
    List salesRes = [];
    try {
      log('Deactivate Filter: ${state.activeFilter}');
      emit(FilterLoading(state.activeFilter));
      HomeModel res = await FilterRepoImp().dataPreprocessing(
        state.activeFilter.contains(FilterType.briefing),
        state.activeFilter.contains(FilterType.report),
        state.activeFilter.contains(FilterType.salesman),
      );
      briefRes = res.briefingData;
      reportRes = res.reportData;
      salesRes = res.salesData;
    } catch (e) {
      emit(FilterError(state.activeFilter, e.toString()));
    }

    if (briefRes.isNotEmpty || reportRes.isNotEmpty || salesRes.isNotEmpty) {
      emit(FilterSuccess(state.activeFilter, briefRes, reportRes, salesRes));
    } else {
      emit(FilterError(state.activeFilter, 'No data available'));
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

  //     if (userCredentials.username != '') {
  //       log('Username: ${userCredentials.username}');
  //       Map<String, dynamic> filterData = await FilterRepoImp()
  //           .fetchBriefingData(userCredentials.username, '2025-05-05');

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
