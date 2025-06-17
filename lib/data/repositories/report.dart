import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sop_mobile/core/constant/api.dart';
import 'package:sop_mobile/domain/repositories/report.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_leasing.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_payment.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_salesman.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_stu.dart';

class ReportRepoImp extends ReportRepo {
  @override
  Future<Map<String, dynamic>> createBasicReport(
    String username,
    String date,
    String dealerName,
    String areaName,
    String personInChange,
  ) async {
    // Simulate a network call
    Uri uri = Uri.https(
      APIConstants.baseUrl,
      APIConstants.salesAndReportEndpoint,
    );

    Map body = {
      "Jenis": "SUBDEALER DATA",
      "Mode": "1",
      "Data": {
        "CustomerID": username,
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
            'status': 'warn',
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
        'status': 'error',
        'data': 'Status Code ${response.statusCode}',
      };
    }
  }

  @override
  Future<Map<String, dynamic>> createReportSTU(
    String username,
    String date,
    StuData stuData,
    int index,
  ) async {
    // Implement the logic to create a report for STU data
    Uri uri = Uri.https(
      APIConstants.baseUrl,
      APIConstants.salesAndReportEndpoint,
    );

    Map body = {
      "Jenis": "SUBDEALER SALESMAN STU",
      "Mode": "1",
      "Data": {
        "CustomerID": username,
        "TransDate": date,
        "Memo": stuData.type,
        "ResultSTU": stuData.result,
        "TargetSTU": stuData.target,
        "LMSTU": stuData.lm,
        "Line": index,
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
      log("Full Response: $res");
      log("Result Msg: ${res['Msg']}, Code: ${res['Code']}");
      log("Data[0] ResultMessage: ${res['Data']?[0]?['ResultMessage']}");
      if (res['Msg'] == 'Sukses' &&
          (res['Code'] == '100' || res['Code'] == '200')) {
        if (res['Data'][0]['ResultMessage'] != null &&
            res['Data'][0]['ResultMessage'] == 'SUKSES') {
          log('Success');
          return {
            'status': 'success',
            'data': 'Laporan STU berhasil dibuat.',
          };
        } else {
          log('Warn');
          return {
            'status': 'warn',
            'data': res['Data'][0]['ResultMessage'],
          };
        }
      } else {
        log('Fail');
        return {
          'status': 'fail',
          'data': 'Laporan STU gagal dibuat.',
        };
      }
    } else {
      log('Response: ${response.statusCode}');
      return {
        'status': 'error',
        'data': 'Status Code ${response.statusCode}',
      };
    }
  }

  @override
  Future<Map<String, dynamic>> createReportPayment(
    String username,
    String date,
    PaymentData paymentData,
    int index,
  ) async {
    // Implement the logic to create a report for Payment data
    Uri uri = Uri.https(
      APIConstants.baseUrl,
      APIConstants.salesAndReportEndpoint,
    );

    Map body = {
      "Jenis": "SUBDEALER PAYMENT",
      "Mode": "1",
      "Data": {
        "CustomerID": username,
        "TransDate": date,
        "Memo": paymentData.type,
        "ResultPayment": paymentData.result,
        "LMPayment": paymentData.lm,
        "Line": index,
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
            'data': 'Laporan Payment berhasil dibuat.',
          };
        } else {
          return {
            'status': 'warn',
            'data': res['Data'][0]['ResultMessage'],
          };
        }
      } else {
        log('Fail');
        return {
          'status': 'fail',
          'data': 'Laporan Payment gagal dibuat.',
        };
      }
    } else {
      log('Response: ${response.statusCode}');
      return {
        'status': 'error',
        'data': 'Status Code ${response.statusCode}',
      };
    }
  }

  @override
  Future<Map<String, dynamic>> createReportLeasing(
    String username,
    String date,
    LeasingData leasingData,
    int index,
  ) async {
    // Implement the logic to create a report for Leasing data
    Uri uri = Uri.https(
      APIConstants.baseUrl,
      APIConstants.salesAndReportEndpoint,
    );

    Map body = {
      "Jenis": "SUBDEALER SPK LEASING",
      "Mode": "1",
      "Data": {
        "CustomerID": username,
        "TransDate": date,
        "Memo": leasingData.type,
        "SPK": leasingData.spk,
        "OpenSPK": leasingData.open,
        "ApprovedSPK": leasingData.accept,
        "RejectedSPK": leasingData.reject,
        "Line": index,
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
            'data': 'Laporan Leasing berhasil dibuat.',
          };
        } else {
          return {
            'status': 'warn',
            'data': res['Data'][0]['ResultMessage'],
          };
        }
      } else {
        log('Fail');
        return {
          'status': 'fail',
          'data': 'Laporan Leasing gagal dibuat.',
        };
      }
    } else {
      log('Response: ${response.statusCode}');
      return {
        'status': 'error',
        'data': 'Status Code ${response.statusCode}',
      };
    }
  }

  @override
  Future<Map<String, dynamic>> createReportSalesman(
    String userId,
    String username,
    String date,
    SalesmanData salesmanData,
    int index,
  ) async {
    // Implement the logic to fetch report data
    Uri uri = Uri.https(
      APIConstants.baseUrl,
      APIConstants.salesAndReportEndpoint,
    );

    Map body = {
      'Jenis': 'SUBDEALER SPK',
      'Mode': '1',
      'Data': {
        'CustomerID': username,
        'TransDate': date,
        'KTPSales': userId,
        'StatusSM': salesmanData.status,
        'SPK': salesmanData.spk,
        'STU': salesmanData.stu,
        'STULM': salesmanData.stuLm,
        "Line": index,
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
            'data': 'Laporan Salesman berhasil dibuat.',
          };
        } else {
          return {
            'status': 'warn',
            'data': res['Data'][0]['ResultMessage'],
          };
        }
      } else {
        log('Fail');
        return {
          'status': 'fail',
          'data': 'Laporan Salesman gagal dibuat.',
        };
      }
    } else {
      log('Response: ${response.statusCode}');
      return {
        'status': 'error',
        'data': 'Status Code ${response.statusCode}',
      };
    }
  }
}
