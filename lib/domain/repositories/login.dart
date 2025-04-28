import 'package:sop_mobile/data/models/login_model.dart';

abstract class LoginRepo {
  Future<LoginModel> login(String username, String password);
  Future<bool> logout();

  // Future<bool> isLoggedIn();
  // Future<String?> getToken();
  // Future<void> saveToken(String token);
  // Future<void> deleteToken();
}
