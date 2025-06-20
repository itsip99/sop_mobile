import 'dart:convert';
import 'dart:developer';

import 'package:sop_mobile/core/constant/api.dart';
import 'package:sop_mobile/data/models/login.dart';
import 'package:sop_mobile/domain/repositories/login.dart';
import 'package:http/http.dart' as http;

class LoginRepoImp implements LoginRepo {
  @override
  Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    // Simulate a network call
    Uri uri = Uri.https(APIConstants.baseUrl, APIConstants.loginEndpoint);

    Map body = {
      "UserID": username,
      "DecryptedPassword": password,
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
          'data': LoginModel.fromJson(res['Data'][0]),
        };
      } else {
        log('Fail');
        return {
          'status': 'fail',
          'data': LoginModel(
            branch: '',
            branchName: '',
            shop: '',
            id: '',
            name: '',
            memo: LoginModel.fromJson(res['Data'][0]).memo,
            data: [],
          ),
        };
      }
    } else {
      log('Response: ${response.statusCode}');
      return {
        'status': 'fail',
        'data': LoginModel(
          branch: '',
          branchName: '',
          shop: '',
          id: '',
          name: '',
          memo: response.statusCode.toString(),
          data: [],
        ),
      };
    }
  }

  @override
  Future<Map<String, dynamic>> logout() async {
    // Simulate a network call
    // Uri uri = Uri.https(APIConstants.baseUrl, APIConstants.logoutEndpoint);

    final res = await http.post(
      Uri.https('', ''),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    if (res.statusCode == 200) {
      return {
        'status': 'success',
        'data': [],
      };
    } else {
      return {
        'status': 'fail',
        'data': [],
      };
    }
  }
}
