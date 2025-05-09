import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sop_mobile/core/constant/api.dart';
import 'package:sop_mobile/data/models/briefing.dart';
import 'package:sop_mobile/data/models/home.dart';
import 'package:sop_mobile/data/models/user.dart';
import 'package:sop_mobile/data/repositories/storage.dart';
import 'package:sop_mobile/domain/repositories/filter.dart';

class FilterRepoImp extends FilterRepo {
  @override
  Future<HomeModel> dataPreprocessing(
    bool isBriefAvailable,
    bool isReportAvailable,
    bool isSalesAvailable,
  ) async {
    UserCredsModel userCredentials =
        await StorageRepoImp().getUserCredentials();

    if (userCredentials.username != '') {
      log('Username: ${userCredentials.username}');

      // ~:Simulate briefing data fetching:~
      Map<String, dynamic> defaultValue = {'status': 'fail', 'data': []};

      Map<String, dynamic> briefData = isBriefAvailable
          ? await FilterRepoImp().fetchBriefingData(
              userCredentials.username,
              '2025-05-05',
            )
          : defaultValue;

      // ~:Simulate report data fetching:~
      // change from Success Map to data retrieval for report
      Map<String, dynamic> reportData =
          isReportAvailable ? {'status': 'success', 'data': []} : defaultValue;

      // ~:Simulate sales data fetching:`
      // change from Success Map to data retrieval for sales
      Map<String, dynamic> salesData =
          isReportAvailable ? {'status': 'success', 'data': []} : defaultValue;

      if (briefData['status'] == 'success' ||
          reportData['status'] == 'success' ||
          salesData['status'] == 'success') {
        log('Data fetched successfully');
        return HomeModel(
          briefingData: briefData['data'] as List<BriefingModel>,
          reportData: reportData['data'] as List,
          salesData: salesData['data'] as List,
        );
      } else {
        log('Data fetch failed');
        return HomeModel(briefingData: [], reportData: [], salesData: []);
      }
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
    // Simulate a network call
    Uri uri = Uri.https(APIConstants.baseUrl, APIConstants.fetchDataEndpoint);

    Map body = {
      "CustomerID": username,
      "TransDate": date,
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
        log('Briefing fetch success');
        final List<BriefingModel> data = (res['Data'] as List)
            .map((e) => BriefingModel.fromJson(e))
            .toList();
        return {
          'status': 'success',
          'data': data,
        };
      } else {
        log('Briefing fetch fail');
        return {
          'status': 'fail',
          'data': [],
        };
      }
    } else {
      log('Response: ${response.statusCode}');
      return {
        'status': 'fail',
        'data': [],
      };
    }
  }
}
