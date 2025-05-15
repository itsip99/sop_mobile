import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sop_mobile/presentation/state/counter/counter_cubit.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_event.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';

import 'fake_repo/login.dart';
import 'fake_repo/storage.dart';

void main() {
  // Run the counter cubit tests
  group('CounterCubit', () {
    late CounterCubit counterCubit;

    setUp(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      counterCubit.close();
    });

    test('initial state is an empty map', () {
      expect(counterCubit.state, isEmpty);
    });

    blocTest(
      'emits updated state when increment is called',
      build: () => counterCubit,
      act: (bloc) => bloc.increment('counter'),
      expect: () => [
        isA<Map<String, int>>()
            .having((state) => state['counter'], 'counter count', 2)
      ],
    );

    blocTest(
      'emits updated state when decrement is called',
      build: () => counterCubit,
      act: (bloc) => bloc.decrement('counter'),
      expect: () => [
        isA<Map<String, int>>()
            .having((state) => state['counter'], 'counter count', 0)
      ],
    );

    blocTest(
      'getCount returns the current state',
      build: () => counterCubit,
      act: (bloc) => bloc.getCount()['counter'],
      expect: () => [],
    );
  });

  // Run the login bloc tests
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
      expect(loginBloc.state, LoginInitial());
    });

    blocTest(
      'emits [LoginLoading, LoginSuccess] when login is successful',
      build: () => loginBloc,
      act: (bloc) async {
        // Arrange
        fakeLogin.setIsLoggedIn(true);

        // Act
        bloc.add(
          LoginButtonPressed(username: 'John Doe', password: '123456'),
        );
      },
      expect: () => [isA<LoginLoading>(), isA<LoginSuccess>()],
    );

    blocTest(
      'emits [LoginLoading, LoginFailure] when login is failed',
      build: () => loginBloc,
      act: (bloc) async {
        // Arrange
        fakeLogin.setIsLoggedIn(false);

        // Act
        bloc.add(
          LoginButtonPressed(username: 'John Doe', password: 'wrongpass'),
        );
      },
      expect: () => [isA<LoginLoading>(), isA<LoginFailure>()],
    );

    blocTest(
      'emits [LoginLoading, LogoutSuccess] when logout is successful',
      build: () => loginBloc,
      act: (bloc) async {
        // Arrange
        fakeLogin.setIsLoggedIn(false);

        // Act
        bloc.add(LogoutButtonPressed());
      },
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginInitial>(),
        isA<LogoutSuccess>(),
      ],
    );
  });
}
