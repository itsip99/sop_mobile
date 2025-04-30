abstract class StorageRepo {
  Future<void> saveUserCredentials(String username, String password);
  Future<List<String>> getUserCredentials();
  Future<void> deleteUserCredentials();
}
