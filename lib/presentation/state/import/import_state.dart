import 'package:equatable/equatable.dart';
import 'package:sop_mobile/presentation/state/base_state.dart';

class ImportState extends BaseState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class ImportInitial extends ImportState {}

class ImportExcelSucceed extends ImportState {
  final String message;

  ImportExcelSucceed(this.message);
}

class ImportExcelFailed extends ImportState {
  final String message;

  ImportExcelFailed(this.message);
}
