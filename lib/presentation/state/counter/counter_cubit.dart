import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<Map<String, int>> {
  CounterCubit() : super({});

  void increment(String type) => emit({...state, type: (state[type] ?? 1) + 1});
  void decrement(String type) => emit({...state, type: (state[type] ?? 1) - 1});
  // void setCount(int newCount) => emit(newCount.clamp(0, 100));

  Map<String, int> getCount() => state;
}
