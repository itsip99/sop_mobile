import 'package:sop_mobile/domain/repositories/login.dart';

import 'login_test.dart';
import 'storage_test.dart';

class MockLogin extends LoginRepo {
  final MockStorageRepository mockStorage;
  final MockLoginRepository mockLogin;

  MockLogin(this.mockStorage, this.mockLogin);

  @override
  Future<Map<String, dynamic>> login(String username, String password) async {
    // Simulate a network call
    return await mockLogin.login(username, password);
  }

  @override
  Future<Map<String, dynamic>> logout() async {
    // Simulate a network call
    return await mockLogin.logout();
  }
}
