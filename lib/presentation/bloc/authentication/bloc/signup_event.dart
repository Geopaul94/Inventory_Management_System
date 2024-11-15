import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class UsernameChanged extends SignUpEvent {
  final String username;
  const UsernameChanged(this.username);

  @override
  List<Object?> get props => [username];
}

class EmailChanged extends SignUpEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class PhoneChanged extends SignUpEvent {
  final String phone;
  const PhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

class PasswordChanged extends SignUpEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class ConfirmPasswordChanged extends SignUpEvent {
  final String confirmPassword;
  const ConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}

class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();
}
