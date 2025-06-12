import 'package:equatable/equatable.dart';
import 'package:sop_mobile/presentation/state/base_state.dart';

class ReportState extends BaseState with EquatableMixin {
  final String message;

  ReportState(this.message);

  @override
  List<Object?> get props => [];
}

class ReportInitial extends ReportState {
  ReportInitial(super.message);
}

class ReportLoading extends ReportState {
  ReportLoading(super.message);
}

class ReportCreationFailed extends ReportState {
  ReportCreationFailed(super.message);
}

class ReportCreationSuccess extends ReportState {
  ReportCreationSuccess(super.message);
}

class ReportCreationWarning extends ReportState {
  ReportCreationWarning(super.message);
}

class ReportCreationError extends ReportState {
  ReportCreationError(super.message);
}
