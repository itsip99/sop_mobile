import 'package:equatable/equatable.dart';
import 'package:sop_mobile/data/models/login.dart';
import 'package:sop_mobile/presentation/state/base_state.dart';

abstract class LoginState extends BaseState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  List<LoginModel> get getLoginInitial => [];
}

class LoginLoading extends LoginState {
  List<LoginModel> get getLoginLoading => [];
}

class LoginSuccess extends LoginState {
  final LoginModel login;

  LoginSuccess(this.login);

  LoginModel get getUserCreds => login;
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);

  String get getLoginFailure => error;
}

class LogoutSuccess extends LoginState {
  LogoutSuccess();
}

class LogoutFailure extends LoginState {
  final String error;

  LogoutFailure(this.error);

  String get getLogoutFailure => error;
}
