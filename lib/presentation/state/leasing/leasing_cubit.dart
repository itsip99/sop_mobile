import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_leasing.dart';

class LeasingCubit extends Cubit<List<LeasingData>> {
  LeasingCubit()
      : super([
          LeasingData('BAF', 0, 0, 0, 0, 0),
          LeasingData('Adira', 0, 0, 0, 0, 0),
          LeasingData('SOF', 0, 0, 0, 0, 0),
        ]);

  void resetData() {
    emit([
      LeasingData('BAF', 0, 0, 0, 0, 0),
      LeasingData('Adira', 0, 0, 0, 0, 0),
      LeasingData('SOF', 0, 0, 0, 0, 0),
    ]);
  }

  void addData() {
    emit([...state, LeasingData('', 0, 0, 0, 0, 0)]);
    log('Current data length: ${state.length}');
  }
}
