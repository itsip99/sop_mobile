import 'package:flutter_bloc/flutter_bloc.dart';

class SalesStatusCubit extends Cubit<bool> {
  SalesStatusCubit() : super(true);

  bool getSalesStatus() => state;

  void setSalesStatus(bool status) {
    emit(status);
  }
}
