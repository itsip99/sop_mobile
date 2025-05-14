import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/data/models/login.dart';
import 'package:sop_mobile/data/models/user.dart';
import 'package:sop_mobile/data/repositories/login.dart';
import 'package:sop_mobile/data/repositories/storage.dart';
import 'package:sop_mobile/domain/repositories/login.dart';
import 'package:sop_mobile/domain/repositories/storage.dart';
import 'package:sop_mobile/presentation/state/login/login_event.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';

class LoginBloc<BaseEvent, BaseState> extends Bloc<LoginEvent, LoginState> {
  LoginRepo loginRepo;
  StorageRepo storageRepo;

  LoginBloc({
    required this.loginRepo,
    required this.storageRepo,
  }) : super(LoginInitial()) {
    on<LoginButtonPressed>(loginHandler);
    on<LogoutButtonPressed>(logoutHandler);
  }

  Future<void> loginHandler(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      UserCredsModel userCredentials =
          await StorageRepoImp().getUserCredentials();

      if (userCredentials.username != '' && userCredentials.password != '') {
        // Simulate a network call
        Map<String, dynamic> user = await LoginRepoImp().login(
          userCredentials.username,
          userCredentials.password,
        );

        if (user['status'] == 'success') {
          // Emit success state with user data
          emit(LoginSuccess(user['data'] as LoginModel));
        } else {
          // Emit failure state with an error message
          emit(LoginFailure((user['data'] as LoginModel).memo));
        }
      } else {
        // Simulate a network call
        Map<String, dynamic> user =
            await LoginRepoImp().login(event.username, event.password);

        if (event.username.isEmpty || event.password.isEmpty) {
          emit(LoginFailure("Username or password cannot be empty"));
          return;
        } else {
          final isLoginSuccess =
              (await loginRepo.login('John Doe', '123456') as LoginModel)
                      .memo ==
                  'Login successful';
          log('isLoginSuccess: $isLoginSuccess');
          final isUserValid = await storageRepo.getUserCredentials() ==
              UserCredsModel(
                username: 'John Doe',
                password: '123456',
              );
          log('isUserValid: $isUserValid');
          if (user['status'] ==
              'success' /*&& isLoginSuccess && isUserValid*/) {
            // Save user credentials to secure storage
            await StorageRepoImp().saveUserCredentials(
              event.username,
              event.password,
            );
            // Emit success state with user data
            emit(LoginSuccess(user['data'] as LoginModel));
          } else {
            // Emit failure state with an error message
            emit(LoginFailure((user['data'] as LoginModel).memo));
          }
        }
      }
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
      await StorageRepoImp().deleteUserCredentials();
      emit(LogoutSuccess());
    } catch (e) {
      // Emit failure state with an error message
      emit(LogoutFailure(e.toString()));
    }
  }
}
