import 'package:sop_mobile/data/models/login.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_leasing.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_payment.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_salesman.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_stu.dart';

abstract class ReportRepo {
  Future<Map<String, dynamic>> createBasicReport(
    String username,
    String date,
    String dealerName,
    String areaName,
    String personInChange,
  );

  Future<Map<String, dynamic>> createReportSTU(
    String username,
    String date,
    StuData stuData,
    int index,
  );

  Future<Map<String, dynamic>> createReportPayment(
    String username,
    String date,
    PaymentData paymentData,
    int index,
  );

  Future<Map<String, dynamic>> createReportLeasing(
    String username,
    String date,
    LeasingData leasingData,
    int index,
  );

  Future<Map<String, dynamic>> createReportSalesman(
    String username,
    String date,
    SalesmanData leasingData,
    int index,
  );
}
