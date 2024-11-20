

import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;
  const LoginErrorState(this.error);

  @override
  List<Object> get props => [error];
}


class LogingoogleButtonLoadingState extends LoginState {}

class LogingoogleButtonSuccessState extends LoginState {}

class LogingoogleButtonErrorState extends LoginState {}