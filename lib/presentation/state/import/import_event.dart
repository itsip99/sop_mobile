import 'package:sop_mobile/presentation/state/base_event.dart';

abstract class ImportEvent extends BaseEvent {}

class ImportResetEvent extends ImportEvent {}

class ImportExcelEvent extends ImportEvent {
  // final List<SalesImportModel> salesmanList;

  ImportExcelEvent(/*{required this.salesmanList}*/);
}
