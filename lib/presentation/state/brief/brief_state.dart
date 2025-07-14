import 'package:equatable/equatable.dart';
import 'package:sop_mobile/data/models/briefing.dart';
import 'package:sop_mobile/presentation/state/base_state.dart';

abstract class BriefState extends BaseState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class BriefInitial extends BriefState {
  List<BriefingModel> get getBriefInitial => [];
}

class BriefLoading extends BriefState {
  List<BriefingModel> get getBriefLoading => [];
}

class BriefCreationSuccess extends BriefState {
  final String resultMessage;

  BriefCreationSuccess(this.resultMessage);

  String get getBriefLoaded => resultMessage;
}

class BriefCreationFail extends BriefState {
  final String error;

  BriefCreationFail(this.error);

  String get getBriefLoadFail => error;
}

class BriefImageLoading extends BriefState {
  List<BriefingModel> get getBriefLoading => [];
}

class BriefImageRetrievalSuccess extends BriefState {
  final String image;

  BriefImageRetrievalSuccess(this.image);

  String get getBriefLoaded => image;
}

class BriefImageRetrievalFail extends BriefState {
  final String message;

  BriefImageRetrievalFail(this.message);

  String get getBriefLoadFail => message;
}
