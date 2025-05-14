import 'package:sop_mobile/data/models/login.dart';
import 'package:sop_mobile/domain/repositories/login.dart';

class FakeLoginRepo implements LoginRepo {
  bool isLoggedIn = true;

  void setIsLoggedIn(bool value) {
    isLoggedIn = value;
  }

  @override
  Future<Map<String, dynamic>> login(String username, String password) async {
    // Simulate a successful login
    if (isLoggedIn) {
      return {
        'status': 'success',
        'data': LoginModel(
          id: '',
          name: '',
          memo: 'Login successful',
          branch: '',
          shop: '',
          data: [],
        ),
      };
    } else {
      // memo: 'Invalid credentials'
      return {
        'status': 'fail',
        'data': LoginModel(
          id: '',
          name: '',
          memo: 'Invalid credentials',
          branch: '',
          shop: '',
          data: [],
        ),
      };
    }
  }

  @override
  Future<Map<String, dynamic>> logout() async {
    return {
      'status': 'success',
      'data': LoginModel(
        id: '',
        name: '',
        memo: 'Logout successful',
        branch: '',
        shop: '',
        data: [],
      ),
    };
  }
}
