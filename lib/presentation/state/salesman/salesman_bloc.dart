import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_event.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_state.dart';

class SalesmanBloc<BaseEvent, BaseState>
    extends Bloc<SalesmanEvent, SalesmanState> {
  SalesmanBloc() : super(SalesmanInitial()) {
    on<AddSalesman>(addSalesmanHandler);
    // on<RemoveSalesman>(removeSalesmanHandler);
  }

  Future<void> addSalesmanHandler(
    AddSalesman event,
    Emitter<SalesmanState> emit,
  ) async {
    try {
      // ~:Network Call Simulation:~
      emit(SalesmanAdded(event.name, event.tier));
    } catch (e) {
      emit(SalesmanError(e.toString()));
    }
  }
}
