import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(1);

  void increment(int count) => emit(count + 1.clamp(0, 100));
  void decrement(int count) => emit(count - 1.clamp(0, 100));
  void setCount(int newCount) => emit(newCount.clamp(0, 100));
}
