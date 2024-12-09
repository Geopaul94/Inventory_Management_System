import 'package:bloc/bloc.dart';
import 'package:inventory_management_system/data/repository/authentication/auth_service.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<OnsignUpButtonClickedEvent>((event, emit) async {
      emit(LoadingState());

      try {
        await AuthService().signup(event.user);
        print('Sign up user bloc');

        emit(SignupSuccessedState());
      } catch (e) {
        // You can customize the error message based on the type of error

        emit(SignUpFailure(e.toString()));
      }
    });
  }
}
