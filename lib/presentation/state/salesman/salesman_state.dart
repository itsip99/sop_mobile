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
  final List<SalesmanData> salesmanDataList;

  SalesmanFetched(
    SalesmanState previousState,
    this.salesList,
    this.salesmanDataList,
  ) : super(previousState.salesDraftList, salesList, salesmanDataList);

  @override
  List<Object?> get props => [salesDraftList, fetchSalesList, salesDataList];
}

class SalesmanAdded extends SalesmanState {
  final List<Map<String, dynamic>>? results;

  SalesmanAdded({this.results}) : super([], [], []);

  @override
  List<Object?> get props => [results];
}

class SalesmanPartialSuccess extends SalesmanState {
  final List<Map<String, dynamic>> results;
  final String? errorMessage;

  SalesmanPartialSuccess(this.results, {this.errorMessage}) : super([], [], []);

  @override
  List<Object?> get props => [results, errorMessage];
}

class SalesmanError extends SalesmanState {
  final String error;

  SalesmanError(this.error) : super([], [], []);

  String get getSalesmanError => 'Error: $error';
}

// ~:Table Insertation:~
class SalesmanModified extends SalesmanState {
  final SalesmanState previousState;
  final List<SalesmanData> newData;

  SalesmanModified(this.previousState, this.newData) : super([], [], newData);
}

// ~:Modify Salesman Status:~
class SalesmanStatusModified extends SalesmanState {
  final String message;

  SalesmanStatusModified(this.message) : super([], [], []);
}

class SalesmanStatusModifyError extends SalesmanState {
  final String error;

  SalesmanStatusModifyError(this.error) : super([], [], []);
}
