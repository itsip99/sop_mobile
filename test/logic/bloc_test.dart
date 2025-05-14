import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_event.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';

import '../fake_repo/login.dart';
import '../fake_repo/storage.dart';

class BlocTest {
  static void login() {
    group('LoginBloc', () {
      late FakeStorageRepo fakeStorage;
      late FakeLoginRepo fakeLogin;
      late LoginBloc loginBloc;

      setUp(() {
        fakeStorage = FakeStorageRepo();
        fakeLogin = FakeLoginRepo();
        loginBloc = LoginBloc(loginRepo: fakeLogin, storageRepo: fakeStorage);
      });

      tearDown(() {
        loginBloc.close();
      });

      test('initial state is an empty map', () {
        expect(loginBloc.state, isEmpty);
      });

      blocTest(
        'emits [LoginLoading, LoginSuccess] when login is successful',
        build: () => loginBloc,
        act: (bloc) {
          // Arrange
          fakeLogin.setIsLoggedIn(true);

          // Act
          loginBloc.add(
            LoginButtonPressed(username: 'John007', password: '123456'),
          );
        },
        expect: () => [
          isA<LoginLoading>(),
          isA<LoginSuccess>(),
        ],
      );
    });
  }
}
