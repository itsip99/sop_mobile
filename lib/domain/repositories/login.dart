abstract class LoginRepo {
  Future<Map<String, dynamic>> login(String username, String password);
  Future<Map<String, dynamic>> logout();

  // Future<bool> isLoggedIn();
  // Future<String?> getToken();
  // Future<void> saveToken(String token);
  // Future<void> deleteToken();
}
