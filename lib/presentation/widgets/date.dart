import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/presentation/state/date/date_cubit.dart';
import 'package:sop_mobile/presentation/widgets/filter.dart';

class DatePicker {
  static void single(BuildContext context) async {
    final cubit = context.read<DateCubit>();
    final currentDate = cubit.getDate();
    String pickedDate = (
      await showDatePicker(
        context: context,
        initialDate: DateTime(
          int.parse(currentDate.split('-')[0]),
          int.parse(currentDate.split('-')[1]),
          int.parse(currentDate.split('-')[2]),
        ),
        currentDate: DateTime(
          int.parse(currentDate.split('-')[0]),
          int.parse(currentDate.split('-')[1]),
          int.parse(currentDate.split('-')[2]),
        ),
        firstDate: DateTime(2015),
        lastDate: DateTime(2500),
      ),
    ).toString();

    if (pickedDate != null) {
      log('Picked date: $pickedDate');
      pickedDate = Formatter.dateCircleBracketFormatter(pickedDate);
      pickedDate = Formatter.dateFormatter(pickedDate);
    } else {
      log('Current date: $currentDate');
      pickedDate = Formatter.dateCircleBracketFormatter(currentDate);
      pickedDate = Formatter.dateFormatter(currentDate);
    }

    log('Set Cubit Date: $pickedDate');
    if (context.mounted) {
      cubit.setDate(context, pickedDate);
      Filter.onDatePressed(context);
    }
  }
}
