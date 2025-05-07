import 'dart:convert';
import 'dart:developer';

import 'package:sop_mobile/core/constant/api.dart';
import 'package:sop_mobile/data/models/briefing.dart';
import 'package:sop_mobile/domain/repositories/filter.dart';

class FilterRepoImp extends FilterRepo {
  get http => null;

  @override
  Future<Map<String, dynamic>> fetchData(
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

    // return BriefingModel.fromJson(jsonDecode(res.body));

    if (response.statusCode <= 200) {
      log('Response: ${response.statusCode}');
      final res = jsonDecode(response.body);
      log("${res['Msg']}, ${res['Code']}");
      if (res['Msg'] == 'Sukses' && res['Code'] == '100') {
        log('Success');
        return {
          'status': 'success',
          'data': BriefingModel.fromJson(res['Data'][0]),
        };
      } else {
        log('Fail');
        return {
          'status': 'fail',
          'data': BriefingModel(
            date: '',
            location: '',
            participants: 0,
            shopManager: 0,
            salesCounter: 0,
            salesman: 0,
            others: 0,
            topic: '',
            pic: '',
            picThumb: '',
          ),
        };
      }
    } else {
      log('Response: ${response.statusCode}');
      return {
        'status': 'fail',
        'data': BriefingModel(
          date: '',
          location: '',
          participants: 0,
          shopManager: 0,
          salesCounter: 0,
          salesman: 0,
          others: 0,
          topic: '',
          pic: '',
          picThumb: '',
        ),
      };
    }
  }
}
