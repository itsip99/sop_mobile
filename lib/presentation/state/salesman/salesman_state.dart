import 'package:equatable/equatable.dart';
import 'package:sop_mobile/data/models/sales_profile.dart';
import 'package:sop_mobile/presentation/state/base_state.dart';

class SalesmanState extends BaseState with EquatableMixin {
  final List<SalesProfileModel> salesProfileList;

  SalesmanState(this.salesProfileList);

  @override
  List<Object?> get props => [salesProfileList];
}

class SalesmanInitial extends SalesmanState {
  SalesmanInitial() : super([]);

  List<SalesProfileModel> get getSalesmanInitial => [];
}

class SalesmanLoading extends SalesmanState {
  SalesmanLoading(SalesmanState previousState)
      : super(previousState.salesProfileList);

  List<SalesProfileModel> get getSalesmanLoading => [];
}

class SalesmanAdded extends SalesmanState {
  final SalesProfileModel salesProfile;

  SalesmanAdded(SalesmanState previousState, this.salesProfile)
      : super([...previousState.salesProfileList, salesProfile]);

  SalesProfileModel get getSalesmanAdded => salesProfile;
}

class SalesmanError extends SalesmanState {
  final String error;

  SalesmanError(SalesmanState previousState, this.error)
      : super(previousState.salesProfileList);

  String get getSalesmanError => 'Error: $error';
}
