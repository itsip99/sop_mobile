import 'package:equatable/equatable.dart';
import 'package:sop_mobile/presentation/state/base_state.dart';

class SalesmanState extends BaseState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class SalesmanInitial extends SalesmanState {
  List<String> get getSalesmanInitial => [];
}

class SalesmanLoading extends SalesmanState {
  List<String> get getSalesmanLoading => [];
}

class SalesmanAdded extends SalesmanState {
  final String name;
  final String tier;

  SalesmanAdded(this.name, this.tier);

  List<String> get getSalesmanAdded => [name, tier];
}

class SalesmanError extends SalesmanState {
  final String error;

  SalesmanError(this.error);

  String get getSalesmanError => 'Error: $error';
}
