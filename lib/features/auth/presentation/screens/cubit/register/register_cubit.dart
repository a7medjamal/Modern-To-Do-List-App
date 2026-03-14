import 'package:cat_to_do_list/features/auth/domain/usecases/send_email_verification.dart';
import 'package:cat_to_do_list/features/auth/domain/usecases/signup_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final SignUpUser _signUpUser;
  final SendEmailVerification _sendEmailVerification;

  RegisterCubit({
    required SignUpUser signUpUser,
    required SendEmailVerification sendEmailVerification,
  }) : _signUpUser = signUpUser,
       _sendEmailVerification = sendEmailVerification,
       super(RegisterInitial());

  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    emit(RegisterLoading());

    try {
      await _signUpUser(email, password);
      await _sendEmailVerification();
      emit(
        RegisterSuccess(
          'Registered successfully!\nPlease check your email to verify your account before logging in.',
        ),
      );
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
