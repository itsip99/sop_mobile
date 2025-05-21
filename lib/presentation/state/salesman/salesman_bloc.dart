import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/data/models/sales_profile.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_event.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_state.dart';

class SalesmanBloc<BaseEvent, BaseState>
    extends Bloc<SalesmanEvent, SalesmanState> {
  SalesmanBloc() : super(SalesmanInitial()) {
    on<ResetSalesman>((event, emit) => emit(SalesmanInitial()));
    on<AddSalesman>(addSalesmanHandler);
    // on<RemoveSalesman>(removeSalesmanHandler);
  }

  Future<void> addSalesmanHandler(
    AddSalesman event,
    Emitter<SalesmanState> emit,
  ) async {
    emit(SalesmanLoading(state));
    try {
      emit(SalesmanAdded(state, SalesProfileModel(event.name, event.tier)));
      // emit(SalesmanState(
      //   [...state.salesProfileList, SalesProfileModel(event.name, event.tier)],
      // ));
    } catch (e) {
      emit(SalesmanError(state, e.toString()));
    }
  }
}
