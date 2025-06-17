import 'package:sop_mobile/data/models/sales.dart';
import 'package:sop_mobile/presentation/state/base_event.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_leasing.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_payment.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_salesman.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_stu.dart';

abstract class ReportEvent extends BaseEvent {}

class InitiateReport extends ReportEvent {
  InitiateReport();
}

class CreateReport extends ReportEvent {
  final String dealerName;
  final String areaName;
  final String personInCharge;
  final List<StuData> stuData;
  final List<PaymentData> paymentData;
  final List<LeasingData> leasingData;
  final List<SalesmanData> salesmanData;
  final List<SalesModel> salesData;

  CreateReport({
    this.dealerName = '',
    this.areaName = '',
    this.personInCharge = '',
    this.stuData = const [],
    this.paymentData = const [],
    this.leasingData = const [],
    this.salesmanData = const [],
    this.salesData = const [],
  });
}
