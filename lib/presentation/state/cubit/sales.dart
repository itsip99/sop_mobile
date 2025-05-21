import 'package:flutter_bloc/flutter_bloc.dart';

class SalesStatusCubit extends Cubit<String> {
  SalesStatusCubit() : super('Sales Counter');

  String getSalesStatus() => state;

  void setSalesStatus(String status) {
    emit(status);
  }
}
