import 'package:sop_mobile/presentation/state/base_event.dart';

abstract class StuEvent extends BaseEvent {}

class ResetStuData extends StuEvent {
  ResetStuData();
}

class ModifyStuResultData extends StuEvent {
  final int rowIndex;
  final int? newResultValue;

  ModifyStuResultData({
    required this.rowIndex,
    this.newResultValue,
  });
}

class ModifyStuTargetData extends StuEvent {
  final int rowIndex;
  final int? newTargetValue;

  ModifyStuTargetData({
    required this.rowIndex,
    this.newTargetValue,
  });
}

class ModifyStuLmData extends StuEvent {
  final int rowIndex;
  final int? newLmValue;

  ModifyStuLmData({
    required this.rowIndex,
    this.newLmValue,
  });
}
