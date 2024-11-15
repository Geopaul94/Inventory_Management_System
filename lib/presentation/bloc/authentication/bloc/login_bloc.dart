import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/login_event.dart';


part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _firebaseAuth;

  String email = '';
  String password = '';

  LoginBloc(this._firebaseAuth) : super(LoginInitial()) {
    on<EmailChanged>((event, emit) {
      email = event.email;
    });

    on<PasswordChanged>((event, emit) {
      password = event.password;
    });

    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
