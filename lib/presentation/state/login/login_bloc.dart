import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_event.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';

class LoginBloc<BaseEvent, BaseState> extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(loginHandler);
  }

  Future<void> loginHandler(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      // Simulate a network call
      final user = await Future.delayed(const Duration(seconds: 2));
      // Emit success state with a dummy token
      emit(LoginSuccess(user));
    } catch (e) {
      // Emit failure state with an error message
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> logoutHandler(
    LogoutButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      // Emit success state with a dummy token
      emit(LoginInitial());
    } catch (e) {
      // Emit failure state with an error message
      emit(LoginFailure(e.toString()));
    }
  }
}
