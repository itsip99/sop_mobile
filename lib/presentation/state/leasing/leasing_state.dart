import 'package:equatable/equatable.dart';
import 'package:sop_mobile/presentation/state/base_state.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_leasing.dart';

class LeasingState extends BaseState with EquatableMixin {
  final List<LeasingData> data;

  LeasingState(this.data);

  @override
  List<Object?> get props => [data];
}

class LeasingInitial extends LeasingState {
  LeasingInitial(super.data);
}

class AddLeasingData extends LeasingState {
  final List<LeasingData> newData;

  AddLeasingData(this.newData) : super(newData);
}
