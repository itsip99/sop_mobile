import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sop_mobile/presentation/state/counter/counter_cubit.dart';

class CubitTest {
  static void counter() {
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
  }
}
