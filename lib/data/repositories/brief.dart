import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sop_mobile/core/constant/api.dart';
import 'package:sop_mobile/domain/repositories/brief.dart';

class BriefRepoImp extends BriefRepo {
  @override
  Future<Map<String, dynamic>> createBriefingReport(
    String username,
    String branch,
    String shop,
    String date,
    String location,
    int participants,
    int manager,
    int counter,
    int sales,
    int other,
    String desc,
    String img,
  ) async {
    // Simulate a network call
    Uri uri = Uri.https(
      APIConstants.baseUrl,
      APIConstants.createBriefDataEndpoint,
    );

    Map body = {
      "Jenis": "SUBDEALER ACTIVITY", // static
      "Mode": "1", // static
      "Data": {
        "CustomerID": username,
        "TransDate": date,
        "Branch": branch,
        "Shop": shop,
        "Lokasi": location,
        "Peserta": participants,
        "SM": manager,
        "SC": counter,
        "Salesman": sales,
        "Other": other,
        "Topic": desc,
        "Pic1": img,
        "PicThumb": img,
      }
    };
    // log('Map Body: $body');

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    // log('Response: $response');

    if (response.statusCode <= 200) {
      log('Response: ${response.statusCode}');
      final res = jsonDecode(response.body);
      log("${res['Msg']}, ${res['Code']}");
      if (res['Msg'] == 'Sukses' && res['Code'] == '100') {
        log('Success');
        return {
          'status': 'success',
          'data': res['Data'][0]['ResultMessage'],
        };
      } else {
        log('Fail');
        return {
          'status': 'fail',
          'data': res['Data'][0]['ResultMessage'],
        };
      }
    } else {
      log('Response: ${response.statusCode}');
      return {
        'status': 'fail',
        'data': response.statusCode,
      };
    }
  }
}
