import 'package:sop_mobile/data/models/user.dart';

abstract class StorageRepo {
  Future<void> saveUserCredentials(String username, String password);
  Future<UserCredsModel> getUserCredentials();
  Future<void> deleteUserCredentials();
}
