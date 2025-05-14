import 'package:sop_mobile/data/models/user.dart';
import 'package:sop_mobile/domain/repositories/storage.dart';

class FakeStorageRepo implements StorageRepo {
  @override
  Future<void> saveUserCredentials(String username, String password) async {}

  @override
  Future<UserCredsModel> getUserCredentials() async {
    return UserCredsModel(username: 'John Doe', password: '123456');
  }

  @override
  Future<void> deleteUserCredentials() async {}
}
