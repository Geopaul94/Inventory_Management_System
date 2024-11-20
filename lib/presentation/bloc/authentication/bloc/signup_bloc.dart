import 'package:bloc/bloc.dart';
import 'package:inventory_management_system/data/repository/authentication/auth_service.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {

    on<OnsignUpButtonClickedEvent>((event, emit) async {
      emit(LoadingState());

      await AuthService().signup(event.user);

      emit(SignupSuccessedState());
      print('dds');
    });
  }
}
