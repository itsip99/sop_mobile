import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sop_mobile/core/constant/api.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/data/models/briefing.dart';
import 'package:sop_mobile/data/models/home.dart';
import 'package:sop_mobile/data/models/report.dart';
import 'package:sop_mobile/data/models/user.dart';
import 'package:sop_mobile/data/repositories/storage.dart';
import 'package:sop_mobile/domain/repositories/filter.dart';

class FilterRepoImp extends FilterRepo {
  @override
  Future<HomeModel> dataPreprocessing(
    bool isBriefAvailable,
    bool isReportAvailable,
    // bool isSalesAvailable,
    String date,
  ) async {
    if (date == '') {
      date = Formatter.dateFormatter(
        Formatter.dateCircleBracketFormatter(DateTime.now().toString()),
      );
    }

    UserCredsModel userCredentials =
        await StorageRepoImp().getUserCredentials();

    if (userCredentials.username != '') {
      log('Username: ${userCredentials.username}');

      // ~:Simulate briefing data fetching:~
      // change from Success Map to data retrieval for briefing
      log('isBriefAvailable: $isBriefAvailable');
      Map<String, dynamic> briefData =
          isBriefAvailable
              ? await fetchBriefingData(userCredentials.username, date)
              : {'status': 'fail', 'data': <BriefingModel>[]};
      log('Briefing data: ${briefData['data']}');
      log('Briefing data type: ${briefData['data'].runtimeType}');

      // ~:Simulate report data fetching:~
      // change from Success Map to data retrieval for report
      log('isReportAvailable: $isReportAvailable');
      Map<String, dynamic> reportData =
          isReportAvailable
              ? await fetchReportData(userCredentials.username, date)
              : {'status': 'fail', 'data': <ReportModel>[]};
      log('Report data: ${reportData['data']}');
      log('Report data type: ${reportData['data'].runtimeType}');

      // ~:Simulate sales data fetching:~
      // change from Success Map to data retrieval for sales
      // log('isSalesAvailable: $isSalesAvailable');
      // Map<String, dynamic> salesData = isSalesAvailable
      //     ? await fetchSalesData(userCredentials.username, date)
      //     : {'status': 'fail', 'data': [] as List<SalesModel>};
      // log('Sales data: ${salesData['data']}');
      // log('Sales data type: ${salesData['data'].runtimeType}');

      return HomeModel(
        briefingData: briefData['status'] == 'success' ? briefData['data'] : [],
        reportData: reportData['status'] == 'success' ? reportData['data'] : [],
        salesData: [],
      );
    } else {
      log('Username is empty');
      return HomeModel(briefingData: [], reportData: [], salesData: []);
    }
  }

  @override
  Future<Map<String, dynamic>> fetchBriefingData(
    String username,
    String date,
  ) async {
    // Simulate a network call or data fetching
    Uri uri = Uri.https(
      APIConstants.baseUrl,
      APIConstants.fetchBriefDataEndpoint,
    );

    Map body = {"CustomerID": username, "TransDate": date};
    log('Map Body: $body');

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    log('Response: $response');

    List<BriefingModel> data = [];
    if (response.statusCode <= 200) {
      log('Response: ${response.statusCode}');
      final res = jsonDecode(response.body);
      log("${res['Msg']}, ${res['Code']}");
      if (res['Msg'] == 'Sukses' && res['Code'] == '100') {
        log('Briefing fetch success');
        data =
            (res['Data'] as List)
                .map((e) => BriefingModel.fromJson(e))
                .toList();
        return {'status': 'success', 'data': data};
      } else {
        log('Briefing fetch fail');
        return {'status': 'fail', 'data': data};
      }
    } else {
      log('Response: ${response.statusCode}');
      return {'status': 'fail', 'data': data};
    }
  }

  @override
  Future<Map<String, dynamic>> fetchReportData(
    String username,
    String date,
  ) async {
    Uri uri = Uri.https(
      APIConstants.baseUrl,
      APIConstants.fetchReportDataEndpoint,
    );

    Map body = {"CustomerID": username, "TransDate": date};
    log('Map Body: $body');

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    log('Response: $response');

    List<ReportModel> data = [];
    if (response.statusCode <= 200) {
      log('Response: ${response.statusCode}');
      final res = jsonDecode(response.body);
      log("${res['Msg']}, ${res['Code']}");
      if (res['Msg'] == 'Sukses' && res['Code'] == '100') {
        log('Briefing fetch success');
        data =
            (res['Data'] as List).map((e) => ReportModel.fromJson(e)).toList();
        return {'status': 'success', 'data': data};
      } else {
        log('Briefing fetch fail');
        return {'status': 'fail', 'data': data};
      }
    } else {
      log('Response: ${response.statusCode}');
      return {'status': 'fail', 'data': data};
    }
  }

  // @override
  // Future<Map<String, dynamic>> fetchSalesData(
  //   String username,
  //   String date,
  // ) async {
  //   List<SalesModel> data = [];
  //   return {
  //     'status': 'success',
  //     'data': data,
  //   };
  // }
}
