import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/presentation/state/date/date_cubit.dart';
import 'package:sop_mobile/presentation/widgets/filter.dart';

class DatePicker {
  static void single(BuildContext context) async {
    final cubit = context.read<DateCubit>();
    final currentDate = cubit.getDate();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(currentDate),
      firstDate: DateTime(2015),
      lastDate: DateTime(2500),
    );

    if (picked != null) {
      final pickedDateString = picked.toString().split(' ')[0];
      log('Picked date: $pickedDateString');
      cubit.setDate(pickedDateString);
      if (context.mounted) {
        Filter.onRefreshOrDateChanged(context);
      }
    }
  }
}
