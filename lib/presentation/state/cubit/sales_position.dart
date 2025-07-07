import 'package:flutter_bloc/flutter_bloc.dart';

class SalesPositionCubit extends Cubit<String> {
  SalesPositionCubit() : super('Sales Counter');

  String getSalesPosition() => state;

  void setSalesPosition(String position) {
    emit(position);
  }
}
