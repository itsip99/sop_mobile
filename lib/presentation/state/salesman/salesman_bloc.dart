import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/data/models/sales.dart';
import 'package:sop_mobile/data/models/sales_profile.dart';
import 'package:sop_mobile/data/models/user.dart';
import 'package:sop_mobile/data/repositories/sales.dart';
import 'package:sop_mobile/data/repositories/storage.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_event.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_state.dart';

class SalesmanBloc<BaseEvent, BaseState>
    extends Bloc<SalesmanEvent, SalesmanState> {
  SalesmanBloc() : super(SalesmanInitial()) {
    on<ResetSalesman>((event, emit) => emit(SalesmanInitial()));
    on<FetchSalesman>(fetchSalesmanHandler);
    on<AddSalesman>(addSalesmanHandler);
    // on<RemoveSalesman>(removeSalesmanHandler);
  }

  Future<void> fetchSalesmanHandler(
    FetchSalesman event,
    Emitter<SalesmanState> emit,
  ) async {
    emit(SalesmanLoading(state));
    try {
      // ~:Secure Storage Simulation:~
      UserCredsModel userCredentials =
          await StorageRepoImp().getUserCredentials();

      if (userCredentials.username != '') {
        // ~:Network Call Simulation:~
        Map<String, dynamic> result =
            await SalesRepoImp().fetchSalesman(userCredentials.username);

        if (result['status'] == 'success') {
          // ~:Emit success state with user data:~
          emit(SalesmanFetched(state, result['data'] as List<SalesModel>));
        } else {
          // ~:Emit failure state with an error message:~
          emit(SalesmanError(state, result['data'] as String));
        }
      } else {
        emit(SalesmanError(state, 'Uuser credentials not found'));
      }
    } catch (e) {
      emit(SalesmanError(state, e.toString()));
    }
  }

  Future<void> addSalesmanHandler(
    AddSalesman event,
    Emitter<SalesmanState> emit,
  ) async {
    emit(SalesmanLoading(state));
    try {
      // emit(SalesmanAdded(
      //   state,
      //   SalesProfileModel(event.id, event.name, event.tier),
      // ));
    } catch (e) {
      emit(SalesmanError(state, e.toString()));
    }
  }
}
