import 'package:sop_mobile/data/models/login_model.dart';
import 'package:sop_mobile/presentation/state/base_state.dart';

abstract class LoginState extends BaseState {}

class LoginInitial extends LoginState {
  @override
  List<LoginModel> get getLoginInitial => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object?> get getLoginLoading => [];
}

class LoginSuccess extends LoginState {
  final LoginModel token;

  LoginSuccess(this.token);

  @override
  List<LoginModel> get getLoginSuccess => [token];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);

  @override
  String get getLoginFailure => error;
}
