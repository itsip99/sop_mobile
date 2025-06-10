import 'package:equatable/equatable.dart';
import 'package:sop_mobile/presentation/state/base_event.dart';

class SalesmanEvent extends BaseEvent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class ResetSalesman extends SalesmanEvent {
  @override
  List<Object?> get props => [];
}

class FetchSalesman extends SalesmanEvent {
  FetchSalesman();
}

class AddSalesman extends SalesmanEvent {
  final String id;
  final String name;
  final String tier;

  AddSalesman(this.id, this.name, this.tier);
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
