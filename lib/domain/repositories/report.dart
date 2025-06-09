import 'package:sop_mobile/data/models/login.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_leasing.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_payment.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_stu.dart';

abstract class ReportRepo {
  Future<Map<String, dynamic>> createReport(
    LoginModel userCreds,
    String date,
    String dealerName,
    String areaName,
    String personInChange,
  );

  Future<Map<String, dynamic>> createReportSTU(
    List<StuData> stuData,
  );

  Future<Map<String, dynamic>> createReportPayment(
    List<PaymentData> paymentData,
  );

  Future<Map<String, dynamic>> createReportLeasing(
    List<LeasingData> leasingData,
  );
}
