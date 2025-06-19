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
  final LoginRepo loginRepo;
  final StorageRepo storageRepo;

  LoginBloc(
    LoginRepo? loginRepo,
    StorageRepo? storageRepo,
  )   : loginRepo = loginRepo ?? LoginRepoImp(),
        storageRepo = storageRepo ?? StorageRepoImp(),
        super(LoginInitial()) {
    on<LoginButtonPressed>(loginHandler);
    on<LogoutButtonPressed>(logoutHandler);
  }

  Future<void> loginHandler(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      UserCredsModel userCredentials = await storageRepo.getUserCredentials();
      log('User credentials: ${userCredentials.username}, ${userCredentials.password}');

      if (userCredentials.username != '' && userCredentials.password != '') {
        Map<String, dynamic> user = await loginRepo.login(
            userCredentials.username, userCredentials.password);

        // ~:Unit Test Passed:~
        // Map<String, dynamic> user = await loginRepo!
        //     .login(userCredentials.username, userCredentials.password);

        if (user['status'] == 'success') {
          // ~:Emit success state with user data:~
          emit(LoginSuccess(user['data'] as LoginModel));
        } else {
          // ~:Emit failure state with an error message:~
          emit(LoginFailure((user['data'] as LoginModel).memo));
        }
      } else {
        Map<String, dynamic> user =
            await loginRepo.login(event.username, event.password);

        // ~:Unit Test Passed:~
        // Map<String, dynamic> user =
        //     await loginRepo!.login(event.username, event.password);

        if (event.username.isEmpty || event.password.isEmpty) {
          log('Username or password cannot be empty');
          emit(LoginFailure("Username or password cannot be empty"));
          return;
        } else {
          if (user['status'] == 'success') {
            log('User logged in successfully');
            await storageRepo.saveUserCredentials(
                event.username, event.password);

            // ~:Unit Test Passed:~
            // await storageRepo!
            //     .saveUserCredentials(event.username, event.password);

            // ~:Emit success state with user data:~
            emit(LoginSuccess(user['data'] as LoginModel));
          } else {
            log('User login failed');
            // ~:Emit failure state with an error message:~
            emit(LoginFailure((user['data'] as LoginModel).memo));
          }
        }
      }
    } catch (e) {
      // ~:Emit failure state with an error message:~
      log(e.toString());
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> logoutHandler(
    LogoutButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    // ~:Emit success state with a dummy token:~
    emit(LoginInitial());

    await storageRepo.deleteUserCredentials();

    // ~:Unit Test Passed:~
    // await storageRepo!.deleteUserCredentials();

    emit(LogoutSuccess());
  }
}
