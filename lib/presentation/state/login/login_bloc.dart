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
  LoginRepo? loginRepo;
  StorageRepo? storageRepo;

  LoginBloc({
    this.loginRepo,
    this.storageRepo,
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
      // ~:Secure Storage Simulation:~
      UserCredsModel userCredentials =
          await StorageRepoImp().getUserCredentials();

      // ~:Unit Test Passed:~
      // UserCredsModel userCredentials = await storageRepo!.getUserCredentials();

      if (userCredentials.username != '' && userCredentials.password != '') {
        // ~:Network Call Simulation:~
        Map<String, dynamic> user = await LoginRepoImp()
            .login(userCredentials.username, userCredentials.password);

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
        // ~:Network Call Simulation:~
        Map<String, dynamic> user =
            await LoginRepoImp().login(event.username, event.password);

        // ~:Unit Test Passed:~
        // Map<String, dynamic> user =
        //     await loginRepo!.login(event.username, event.password);

        if (event.username.isEmpty || event.password.isEmpty) {
          emit(LoginFailure("Username or password cannot be empty"));
          return;
        } else {
          if (user['status'] == 'success') {
            // ~:Save user credentials:~
            await StorageRepoImp()
                .saveUserCredentials(event.username, event.password);

            // ~:Unit Test Passed:~
            // await storageRepo!
            //     .saveUserCredentials(event.username, event.password);

            // ~:Emit success state with user data:~
            emit(LoginSuccess(user['data'] as LoginModel));
          } else {
            // ~:Emit failure state with an error message:~
            emit(LoginFailure((user['data'] as LoginModel).memo));
          }
        }
      }
    } catch (e) {
      // ~:Emit failure state with an error message:~
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

    // ~:Network Call Simulation:~
    await StorageRepoImp().deleteUserCredentials();

    // ~:Unit Test Passed:~
    // await storageRepo!.deleteUserCredentials();

    emit(LogoutSuccess());
  }
}
