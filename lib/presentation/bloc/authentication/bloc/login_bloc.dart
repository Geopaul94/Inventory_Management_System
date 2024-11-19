// login_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  LoginBloc(this._firebaseAuth, this._googleSignIn) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<GoogleLoginSubmitted>(_onGoogleLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> _onGoogleLoginSubmitted(
    GoogleLoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
