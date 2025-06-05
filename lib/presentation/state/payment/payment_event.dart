import 'package:sop_mobile/presentation/state/base_event.dart';

abstract class PaymentEvent extends BaseEvent {}

class ResetPaymentData extends PaymentEvent {
  ResetPaymentData();
}

class PaymentDataAdded extends PaymentEvent {
  PaymentDataAdded();
}

class PaymentDataModified extends PaymentEvent {
  final int rowIndex;
  final int? newResultValue;
  final int? newTargetValue;

  PaymentDataModified({
    required this.rowIndex,
    this.newResultValue,
    this.newTargetValue,
  });
}
