// login_bloc.dart
import 'package:bloc/bloc.dart';

import 'package:inventory_management_system/data/repository/authentication/auth_service.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/login_event.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginSubmittedEvent>(_onLoginSubmitted);
    on<GoogleLoginSubmitted>(_onGoogleLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    try {
      await AuthService()
          .loginWithEmailAndPassword(event.email, event.password);
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> _onGoogleLoginSubmitted(
    GoogleLoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    try {
      // Delegate sign-in with credential to AuthService (assuming it exists)
      await AuthService().loginWithGoogle();

      // Emit LoginSuccess on successful sign-in
      emit(LoginSuccessState());
    } catch (error) {
      // Handle any errors during Google sign-in or Firebase authentication
      emit(LoginErrorState(error.toString()));
    }
  }
}
