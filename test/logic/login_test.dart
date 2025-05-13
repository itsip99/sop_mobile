import 'package:mockito/mockito.dart';
import 'package:sop_mobile/data/models/login.dart';
import 'package:sop_mobile/data/models/user.dart';
import 'package:sop_mobile/domain/repositories/login.dart';

import 'storage_test.dart';

class MockLoginRepository extends Mock implements LoginRepo {
  final MockStorageRepository storageRepo = MockStorageRepository();

  @override
  Future<Map<String, dynamic>> login(String username, String password) async {
    // TODO: implement login
    UserCredsModel userCreds = await storageRepo.getUserCredentials();

    if (userCreds.username == 'JOHN007' && userCreds.password == '123456') {
      return {
        'status': 'success',
        'data': LoginModel(
          id: 'JOHN007',
          name: '',
          memo: '',
          branch: '',
          shop: '',
          data: [],
        ),
      };
    } else {
      return {
        'status': 'failed',
        'data': LoginModel(
          id: '',
          name: '',
          memo: '',
          branch: '',
          shop: '',
          data: [],
        ),
      };
    }
  }

  @override
  Future<Map<String, dynamic>> logout() async {
    // TODO: implement logout
    return {
      'status': 'success',
      'data': LoginModel(
        id: '',
        name: '',
        memo: '',
        branch: '',
        shop: '',
        data: [],
      ),
    };
  }
}
