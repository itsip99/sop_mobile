import 'package:equatable/equatable.dart';
import 'package:sop_mobile/data/models/sales.dart';
import 'package:sop_mobile/data/models/sales_profile.dart';
import 'package:sop_mobile/presentation/state/base_state.dart';

class SalesmanState extends BaseState with EquatableMixin {
  final List<SalesProfileModel> salesDraftList;
  final List<SalesModel> fetchSalesList;

  SalesmanState(this.salesDraftList, this.fetchSalesList);

  @override
  List<Object?> get props => salesDraftList;
}

class SalesmanInitial extends SalesmanState {
  SalesmanInitial() : super([], []);

  List<SalesProfileModel> get getSalesmanInitial => [];
}

class SalesmanLoading extends SalesmanState {
  SalesmanLoading(SalesmanState previousState)
      : super(previousState.salesDraftList, previousState.fetchSalesList);

  List<SalesProfileModel> get getSalesmanLoading => [];
}

class SalesmanFetched extends SalesmanState {
  final List<SalesModel> salesList;

  SalesmanFetched(SalesmanState previousState, this.salesList)
      : super(previousState.salesDraftList, salesList);
}

class SalesmanAdded extends SalesmanState {
  // final SalesProfileModel salesProfile;

  SalesmanAdded(
      // SalesmanState previousState,
      /*this.salesProfile*/
      // ) : super([...previousState.salesDraftList /*, salesProfile*/],
      )
      : super([], []);

  // SalesProfileModel get getSalesmanAdded => salesProfile;
}

class SalesmanError extends SalesmanState {
  final String error;

  SalesmanError(/*SalesmanState previousState,*/ this.error)
      : super(/*previousState.salesDraftList, previousState.fetchSalesList*/ [],
            []);

  String get getSalesmanError => 'Error: $error';
}
