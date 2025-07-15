import 'package:equatable/equatable.dart';
import 'package:sop_mobile/data/models/sales_import.dart';
import 'package:sop_mobile/presentation/state/base_event.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_salesman.dart';

class SalesmanEvent extends BaseEvent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class ResetSalesman extends SalesmanEvent {
  final List<SalesmanData> salesDraftList;

  ResetSalesman(this.salesDraftList);
}

class FetchSalesman extends SalesmanEvent {
  FetchSalesman();
}

class AddSalesman extends SalesmanEvent {
  final String id;
  final String name;
  final String tier;
  final int status;

  AddSalesman(this.id, this.name, this.tier, this.status);
}

class AddSalesmanList extends SalesmanEvent {
  final List<NewSalesModel> salesDraftList;

  AddSalesmanList(this.salesDraftList);
}

class ModifySalesman extends SalesmanEvent {
  final int rowIndex;
  final String columnName;
  final int newValue;

  ModifySalesman({
    required this.rowIndex,
    required this.columnName,
    required this.newValue,
  });

  @override
  List<Object?> get props => [rowIndex, columnName, newValue];
}

class ModifySalesmanStatus extends SalesmanEvent {
  final NewSalesModel sales;

  ModifySalesmanStatus({required this.sales});
}
