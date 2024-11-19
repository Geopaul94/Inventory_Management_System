// login_bloc.dart


// login_event.dart
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  const LoginSubmitted(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class GoogleLoginSubmitted extends LoginEvent {}
