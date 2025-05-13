// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'logic/login_test.dart';
import 'logic/secure_storage_test.dart';
import 'logic/storage_test.dart';

void main() {
  MockSecureStorage mockSecureStorage;
  MockStorageRepository mockStorage;
  MockLoginRepository mockLogin;

  setUp(() {
    mockStorage = MockStorageRepository();
    mockLogin = MockLoginRepository();
  });
}
