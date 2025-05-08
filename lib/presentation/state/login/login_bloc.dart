import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/data/models/login.dart';
import 'package:sop_mobile/data/models/user.dart';
import 'package:sop_mobile/data/repositories/login.dart';
import 'package:sop_mobile/data/repositories/storage.dart';
import 'package:sop_mobile/presentation/state/login/login_event.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';

class LoginBloc<BaseEvent, BaseState> extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(loginHandler);
    on<LogoutButtonPressed>(logoutHandler);
    // on<LoadUserData>(readUserCredentials);
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
          if (user['status'] == 'success') {
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

  // Future<void> readUserCredentials(
  //   LoadUserData event,
  //   Emitter<LoginState> emit,
  // ) async {
  //   emit(LoginLoading());
  //   try {
  //     List<String> userCredentials =
  //         await StorageRepoImp().getUserCredentials();
  //
  //     if (userCredentials[0] != '' && userCredentials[1] != '') {
  //       // Simulate a network call
  //       Map<String, dynamic> user =
  //           await LoginRepoImp().login(userCredentials[0], userCredentials[1]);
  //
  //       if (user['status'] == 'success') {
  //         // Emit success state with user data
  //         emit(LoginSuccess(user['data'] as LoginModel));
  //       } else {
  //         // Emit failure state with an error message
  //         emit(LoginFailure((user['data'] as LoginModel).memo));
  //       }
  //     } else {
  //       emit(LoginInitial());
  //     }
  //   } catch (e) {
  //     // Emit failure state with an error message
  //     emit(LoginFailure(e.toString()));
  //   }
  // }
}
