import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sop_mobile/data/models/user.dart';
import 'package:sop_mobile/domain/repositories/storage.dart';

class StorageRepoImp extends StorageRepo {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  Future<void> saveUserCredentials(
    String username,
    String password,
  ) async {
    await storage.write(key: 'username', value: username);
    await storage.write(key: 'password', value: password);
  }

  @override
  Future<UserCredsModel> getUserCredentials() async {
    String username = await storage.read(key: 'username') ?? '';
    String password = await storage.read(key: 'password') ?? '';

    return UserCredsModel(username: username, password: password);
  }

  @override
  Future<void> deleteUserCredentials() async {
    await storage.deleteAll();
  }
}
