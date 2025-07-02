import 'dart:io';

import 'package:sop_mobile/presentation/state/base_event.dart';

abstract class ImportEvent extends BaseEvent {}

class ImportResetEvent extends ImportEvent {}

class ImportExcelEvent extends ImportEvent {
  final File file;

  ImportExcelEvent({required this.file});
}
