import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/presentation/widgets/filter.dart';

class DateCubit extends Cubit<String> {
  DateCubit() : super(DateTime.now().toString().split(' ')[0]);

  void setDate(BuildContext context, String date) async {
    String pickedDate = (
      await showDatePicker(
        context: context,
        initialDate: DateTime(
          int.parse(date.split('-')[0]),
          int.parse(date.split('-')[1]),
          int.parse(date.split('-')[2]),
        ),
        currentDate: DateTime(
          int.parse(date.split('-')[0]),
          int.parse(date.split('-')[1]),
          int.parse(date.split('-')[2]),
        ),
        firstDate: DateTime(2015),
        lastDate: DateTime(2500),
      ),
    ).toString();

    log('Picked Date: $pickedDate');
    if (pickedDate != '(null)') {
      pickedDate = Formatter.dateCircleBracketFormatter(pickedDate);
      pickedDate = Formatter.dateFormatter(pickedDate);
      log('Formatted Date changed: $pickedDate');
      emit(pickedDate);
      if (context.mounted) Filter.onDatePressed(context);
    } else {
      pickedDate = Formatter.dateCircleBracketFormatter(date);
      pickedDate = Formatter.dateFormatter(pickedDate);
      log('Formatted Date not changed: $pickedDate');
      emit(pickedDate);
    }
  }

  String getDate() => state;
}
