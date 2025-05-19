import 'package:equatable/equatable.dart';
import 'package:sop_mobile/presentation/state/base_event.dart';

class SalesmanEvent extends BaseEvent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class AddSalesman extends SalesmanEvent {
  final String name;
  final String tier;

  AddSalesman(this.name, this.tier);
}
