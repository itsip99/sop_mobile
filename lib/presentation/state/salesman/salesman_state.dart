import 'package:equatable/equatable.dart';
import 'package:sop_mobile/data/models/sales.dart';
import 'package:sop_mobile/data/models/sales_profile.dart';
import 'package:sop_mobile/presentation/state/base_state.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_salesman.dart';

class SalesmanState extends BaseState with EquatableMixin {
  final List<SalesProfileModel> salesDraftList;
  final List<SalesModel> fetchSalesList;
  final List<SalesmanData> salesDataList;

  SalesmanState(this.salesDraftList, this.fetchSalesList, this.salesDataList);

  @override
  List<Object?> get props => [salesDraftList, fetchSalesList, salesDataList];
}

class SalesmanInitial extends SalesmanState {
  SalesmanInitial(
    super.salesDraftList,
    super.fetchSalesList,
    super.salesDataList,
  );
}

class SalesmanLoading extends SalesmanState {
  SalesmanLoading(SalesmanState previousState)
      : super(previousState.salesDraftList, previousState.fetchSalesList, []);

  List<SalesProfileModel> get getSalesmanLoading => [];
}

class SalesmanFetched extends SalesmanState {
  final List<SalesModel> salesList;

  SalesmanFetched(SalesmanState previousState, this.salesList)
      : super(previousState.salesDraftList, salesList, []);
}

class SalesmanAdded extends SalesmanState {
  // final SalesProfileModel salesProfile;

  SalesmanAdded(
      // SalesmanState previousState,
      /*this.salesProfile*/
      // ) : super([...previousState.salesDraftList /*, salesProfile*/],
      )
      : super([], [], []);

  // SalesProfileModel get getSalesmanAdded => salesProfile;
}

class SalesmanError extends SalesmanState {
  final String error;

  SalesmanError(/*SalesmanState previousState,*/ this.error)
      : super(/*previousState.salesDraftList, previousState.fetchSalesList*/ [],
            [], []);

  String get getSalesmanError => 'Error: $error';
}

class SalesmanModified extends SalesmanState {
  final List<SalesmanData> newData;

  SalesmanModified(this.newData) : super([], [], newData);
}
