import 'package:sop_mobile/presentation/state/base_event.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_leasing.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_payment.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_stu.dart';

abstract class ReportEvent extends BaseEvent {}

class CreateReport extends ReportEvent {
  final String dealerName;
  final String areaName;
  final String personInChange;
  final List<StuData> stuData;
  final List<PaymentData> paymentData;
  final List<LeasingData> leasingData;

  CreateReport({
    this.dealerName = '',
    this.areaName = '',
    this.personInChange = '',
    this.stuData = const [],
    this.paymentData = const [],
    this.leasingData = const [],
  });
}
