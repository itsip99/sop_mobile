import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';

class DateCubit extends Cubit<String> {
  DateCubit() : super(Formatter.dateFormatter(DateTime.now().toString().split(' ')[0]));

  void setDate(String date) {
    String formattedDate = Formatter.dateCircleBracketFormatter(date);
    formattedDate = Formatter.dateFormatter(formattedDate);
    log('Date changed: $formattedDate');
    emit(formattedDate);
  }

  String getDate() => state;
}
