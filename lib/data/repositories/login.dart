import 'dart:convert';

import 'package:sop_mobile/core/constant/api.dart';
import 'package:sop_mobile/data/models/login_model.dart';
import 'package:sop_mobile/domain/repositories/login.dart';
import 'package:http/http.dart' as http;

class LoginRepoImp extends LoginRepo {
  @override
  Future<LoginModel> login(String username, String password) async {
    // Simulate a network call
    Uri uri = Uri.https(APIConstants.baseUrl, APIConstants.loginEndpoint);

    Map body = {
      "UserID": username,
      "DecryptedPassword": password,
    };

    final res = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode(body),
    );

    // return LoginModel.fromJson(jsonDecode(res.body));

    if (res.statusCode <= 200) {
      final data = jsonDecode(res.body);
      if (data['Status'] == 'Sukses' && data['Code'] == '100') {
        return LoginModel.fromJson(data['Data']);
      } else {
        return LoginModel(
          id: '',
          name: '',
          memo: LoginModel.fromJson(data['Data']).memo,
          branch: '',
          shop: '',
          data: [],
        );
      }
    } else {
      return LoginModel(
        id: '',
        name: '',
        memo: res.statusCode.toString(),
        branch: '',
        shop: '',
        data: [],
      );
    }
  }

  @override
  Future<bool> logout() async {
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
      return true;
    } else {
      return false;
    }
  }
}
