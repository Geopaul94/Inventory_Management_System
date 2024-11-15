import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final FirebaseAuth _firebaseAuth;

  String username = '';
  String email = '';
  String phone = '';
  String password = '';
  String confirmPassword = '';

  SignUpBloc(this._firebaseAuth) : super(SignUpInitial()) {
    on<UsernameChanged>((event, emit) {
      username = event.username;
    });

    on<EmailChanged>((event, emit) {
      email = event.email;
    });

    on<PhoneChanged>((event, emit) {
      phone = event.phone;
    });

    on<PasswordChanged>((event, emit) {
      password = event.password;
    });

    on<ConfirmPasswordChanged>((event, emit) {
      confirmPassword = event.confirmPassword;
    });

    on<SignUpSubmitted>((event, emit) async {
      emit(SignUpLoading());

      if (password != confirmPassword) {
        emit(SignUpFailure('Passwords do not match'));
        return;
      }

      try {
        UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // After user is signed up, you can save additional data to Firestore or RTDB.
        // For example, saving username and phone in Firestore.
        // FirebaseFirestore.instance.collection('users').doc(userCredential.user.uid).set({
        //   'username': username,
        //   'phone': phone,
        // });

        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure(e.toString()));
      }
    });
  }
}
