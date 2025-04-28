import 'package:sop_mobile/presentation/state/base_event.dart';

abstract class LoginEvent extends BaseEvent {}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressed(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

class LogoutButtonPressed extends LoginEvent {
  LogoutButtonPressed();

  @override
  List<Object?> get props => [];
}
