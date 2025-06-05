import 'package:equatable/equatable.dart';
import 'package:sop_mobile/presentation/state/base_state.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_payment.dart';

class PaymentState extends BaseState with EquatableMixin {
  final List<PaymentData> data;

  PaymentState(this.data);

  @override
  List<Object?> get props => [data];
}

class PaymentInitial extends PaymentState {
  PaymentInitial(super.data);
}

class PaymentModified extends PaymentState {
  final List<PaymentData> newData;

  PaymentModified(this.newData) : super(newData);
}
