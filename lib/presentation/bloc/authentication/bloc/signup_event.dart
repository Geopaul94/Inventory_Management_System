import 'package:equatable/equatable.dart';
import 'package:inventory_management_system/data/models/user_data_model.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class OnsignUpButtonClickedEvent extends SignUpEvent {
  final UserModel user;

  const OnsignUpButtonClickedEvent({required this.user});
}
