import 'package:equatable/equatable.dart';
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

class ModifySalesman extends SalesmanEvent {
  final int rowIndex;
  final int? newSpkValue;
  final int? newStuValue;
  final int? newLmValue;

  ModifySalesman({
    required this.rowIndex,
    this.newSpkValue,
    this.newStuValue,
    this.newLmValue,
  });
}
