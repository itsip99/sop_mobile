import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sop_mobile/core/constant/api.dart';
import 'package:sop_mobile/data/models/sales.dart';
import 'package:sop_mobile/domain/repositories/sales.dart';

class SalesRepoImp extends SalesRepo {
  @override
  Future<Map<String, dynamic>> fetchSalesman(String username) async {
    // Simulate a network call
    Uri uri = Uri.https(
      APIConstants.baseUrl,
      APIConstants.fetchSalesProfileEndpoint,
    );

    Map body = {
      'CustomerID': username,
    };
    log('Map Body: $body');

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    log('Response: $response');

    // return LoginModel.fromJson(jsonDecode(res.body));

    if (response.statusCode <= 200) {
      log('Response: ${response.statusCode}');
      final res = jsonDecode(response.body);
      log("${res['Msg']}, ${res['Code']}");
      if (res['Msg'] == 'Sukses' && res['Code'] == '100') {
        log('Success');
        return {
          'status': 'success',
          'data': (res['Data'] as List)
              .map((item) => SalesModel.fromJson(item))
              .toList(),
        };
      } else {
        log('Fail');
        return {
          'status': 'fail',
          'data': 'Failed to fetch data',
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
  Future<Map<String, dynamic>> addSalesman(
    String userId,
    String id,
    String name,
    String tier,
  ) async {
    // Simulate a network call
    Uri uri = Uri.https(
      APIConstants.baseUrl,
      APIConstants.addSalesProfileEndpoint,
    );

    Map body = {
      'Jenis': 'SALESMAN',
      'Mode': '1',
      'Data': {
        'CustomerID': userId,
        'KTP': id,
        'SName': name,
        'EntryLevel': tier,
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
        // Check if the result message contains 'duplicate key'
        final message = (res['Data'] as List)[0]['ResultMessage'].toString();
        if (message.toLowerCase().contains('duplicate key')) {
          log('Duplicate key found');
          return {
            'status': 'fail',
            'data': 'Duplicate key found.',
          };
        } else if (message.toLowerCase() == 'sukses') {
          log('Success');
          return {
            'status': 'success',
            'data': (res['Data'] as List)[0]['ResultMessage'],
          };
        }

        log('Something\'s wrong');
        return {
          'status': 'success',
          'data': 'Something went wrong.',
        };
      } else {
        log('Fail');
        return {
          'status': 'fail',
          'data': 'Failed to fetch data',
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
}
