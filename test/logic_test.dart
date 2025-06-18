import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sop_mobile/presentation/state/counter/counter_cubit.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_event.dart';
import 'package:sop_mobile/core/constant/enum.dart';
import 'package:sop_mobile/presentation/state/filter/filter_bloc.dart';
import 'package:sop_mobile/presentation/state/filter/filter_event.dart';
import 'package:sop_mobile/presentation/state/filter/filter_state.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';

import 'fake_repo/filter.dart';
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
        bloc.add(LoginButtonPressed(username: '', password: ''));
      },
      expect: () => [isA<LoginLoading>(), isA<LoginSuccess>()],
    );

    blocTest(
      'emits [LoginLoading, LoginFailure] when User Credential is empty',
      build: () => loginBloc,
      act: (bloc) async {
        // Arrange
        fakeLogin.setIsLoggedIn(false);

        // Act
        bloc.add(
          LoginButtonPressed(username: 'John Doe', password: '123456'),
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

  // Run the Filter bloc tests
  group('FilterBloc', () {
    late FilterBloc filterBloc;
    late FakeFilterRepo fakeFilterRepo;
    const testDate = '2025-06-18';

    setUp(() {
      fakeFilterRepo = FakeFilterRepo();
      // Inject the fake repository into the bloc
      filterBloc = FilterBloc();
    });

    tearDown(() {
      filterBloc.close();
    });

    test('initial state is FilterInitial with briefing filter active', () {
      expect(filterBloc.state, isA<FilterInitial>());
      expect((filterBloc.state as FilterInitial).activeFilter,
          contains(FilterType.briefing));
    });

    blocTest<FilterBloc, FilterState>(
      'emits [FilterLoading, FilterSuccess] when adding a new filter',
      build: () => filterBloc,
      act: (bloc) {
        bloc.add(FilterAdded(FilterType.report, testDate));
      },
      expect: () => [
        isA<FilterState>(),
        isA<FilterLoading>(),
        isA<FilterSuccess>().having(
          (s) => s.activeFilter,
          'active filters',
          containsAll([FilterType.briefing, FilterType.report]),
        ),
      ],
    );

    blocTest<FilterBloc, FilterState>(
      'does not add duplicate filters',
      build: () => filterBloc,
      act: (bloc) {
        // Adding briefing filter which is already in initial state
        bloc.add(FilterAdded(FilterType.briefing, testDate));
      },
      expect: () => [
        // Should not emit any new states as the filter already exists
      ],
    );

    blocTest<FilterBloc, FilterState>(
      'emits [FilterLoading, FilterSuccess] when removing a filter',
      build: () => filterBloc,
      act: (bloc) {
        // First add a filter to remove
        bloc.add(FilterAdded(FilterType.report, testDate));
        // Then remove it
        bloc.add(FilterRemoved(FilterType.report, testDate));
      },
      expect: () => [
        isA<FilterLoading>(),
        isA<FilterSuccess>(),
        isA<FilterLoading>(),
        isA<FilterSuccess>()
            .having(
              (s) => s.activeFilter,
              'active filters after removal',
              contains(FilterType.briefing),
            )
            .having(
              (s) => s.activeFilter,
              'does not contain removed filter',
              isNot(contains(FilterType.report)),
            ),
      ],
    );

    blocTest<FilterBloc, FilterState>(
      'emits [FilterLoading, FilterSuccess] when modifying date',
      build: () => filterBloc,
      act: (bloc) {
        const newDate = '2025-06-19';
        bloc.add(FilterModified(newDate));
      },
      expect: () => [
        isA<FilterLoading>(),
        isA<FilterSuccess>(),
      ],
    );

    blocTest<FilterBloc, FilterState>(
      'emits [FilterLoading, FilterError] when data fetch fails',
      build: () {
        fakeFilterRepo.shouldSucceed = false;
        return filterBloc;
      },
      act: (bloc) {
        bloc.add(FilterAdded(FilterType.report, testDate));
      },
      expect: () => [
        isA<FilterLoading>(),
        isA<FilterError>(),
      ],
    );

    blocTest<FilterBloc, FilterState>(
      'handles empty data response',
      build: () {
        fakeFilterRepo.hasData = false;
        return filterBloc;
      },
      act: (bloc) {
        bloc.add(FilterAdded(FilterType.report, testDate));
      },
      expect: () => [
        isA<FilterLoading>(),
        isA<FilterError>(),
      ],
    );
  });
}
