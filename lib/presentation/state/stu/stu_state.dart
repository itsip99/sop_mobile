import 'package:equatable/equatable.dart';
import 'package:sop_mobile/presentation/state/base_state.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_stu.dart';

class StuState extends BaseState with EquatableMixin {
  final List<StuData> data;

  StuState(this.data);

  @override
  List<Object?> get props => [data];
}

class StuInitial extends StuState {
  StuInitial(super.data);
}

class StuDataModified extends StuState {
  final List<StuData> newData;

  StuDataModified(this.newData) : super(newData);
}
