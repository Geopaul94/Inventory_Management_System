// login_bloc.dart
import 'package:bloc/bloc.dart';

import 'package:inventory_management_system/data/repository/authentication/auth_service.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/login_event.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {


  LoginBloc() : super(LoginInitialState()) {
    on<LoginSubmittedEvent>(_onLoginSubmitted);
  //  on<GoogleLoginSubmitted>(_onGoogleLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    try {
      await AuthService().loginWithEmailAndPassword(event.email, event.password);
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

 
// Future<void> _onGoogleLoginSubmitted(
//   GoogleLoginSubmitted event,
//   Emitter<LoginState> emit,
// ) async {
//   emit(LoginLoading());
//   try {
//     // Call AuthService.signIn() to handle Google sign-in flow
//     final UserCredential googleUser = await AuthService.sugn();

//     // Extract Google authentication information
//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//     // Create GoogleAuthProvider credential using access token and ID token
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     // Delegate sign-in with credential to AuthService (assuming it exists)
//     await AuthService().signInWithCredential(credential);

//     // Emit LoginSuccess on successful sign-in
//     emit(LoginSuccess());
//   } catch (error) {
//     // Handle any errors during Google sign-in or Firebase authentication
//     emit(LoginFailure(error.toString()));
//   }
// }
}
