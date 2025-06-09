import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sop_mobile/core/constant/api.dart';
import 'package:sop_mobile/data/models/login.dart';
import 'package:sop_mobile/domain/repositories/report.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_leasing.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_payment.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_stu.dart';

class ReportRepoImp extends ReportRepo {
  @override
  Future<Map<String, dynamic>> createReport(
    LoginModel userCreds,
    String date,
    String dealerName,
    String areaName,
    String personInChange,
  ) async {
    // Simulate a network call
    Uri uri = Uri.https(
      APIConstants.baseUrl,
      APIConstants.reportDataEndpoint,
    );

    Map body = {
      "Jenis": "SUBDEALER DATA",
      "Mode": "1",
      "Data": {
        "CustomerID": userCreds.id,
        "TransDate": date,
        "CName": dealerName,
        "Area": areaName,
        "PIC": personInChange,
      }
    };
    log('Map Body: $body');

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    log('Response: $response');

    if (response.statusCode <= 200) {
      log('Response: ${response.statusCode}');
      final res = jsonDecode(response.body);
      log("${res['Msg']}, ${res['Code']}");
      if (res['Msg'] == 'Sukses' && res['Code'] == '100') {
        log('Success');
        if (res['Data'][0]['ResultMessage'] != null &&
            res['Data'][0]['ResultMessage'] == 'SUKSES') {
          return {
            'status': 'success',
            'data': 'Laporan berhasil dibuat.',
          };
        } else {
          return {
            'status': 'success',
            'data': res['Data'][0]['ResultMessage'],
          };
        }
      } else {
        log('Fail');
        return {
          'status': 'fail',
          'data': 'Laporan gagal dibuat.',
        };
      }
    } else {
      log('Response: ${response.statusCode}');
      return {
        'status': 'fail',
        'data': 'Status Code ${response.statusCode}',
      };
    }
  }

  @override
  Future<Map<String, dynamic>> createReportSTU(List<StuData> stuData) async {
    // Implement the logic to create a report for STU data
    return {'status': 'STU Report Created'};
  }

  @override
  Future<Map<String, dynamic>> createReportPayment(
      List<PaymentData> paymentData) async {
    // Implement the logic to create a report for Payment data
    return {'status': 'Payment Report Created'};
  }

  @override
  Future<Map<String, dynamic>> createReportLeasing(
      List<LeasingData> leasingData) async {
    // Implement the logic to create a report for Leasing data
    return {'status': 'Leasing Report Created'};
  }
}
