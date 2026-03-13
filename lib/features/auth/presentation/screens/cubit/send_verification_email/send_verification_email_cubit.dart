import 'package:flutter_bloc/flutter_bloc.dart';
import 'send_verification_email_state.dart';

class SendVerificationEmailCubit extends Cubit<SendVerificationEmailState> {
  SendVerificationEmailCubit() : super(SendVerificationEmailInitial());

  Future<void> sendVerificationEmail() async {
    emit(SendVerificationEmailLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));

      emit(SendVerificationEmailSuccess());
    } catch (e) {
      emit(SendVerificationEmailFailure(e.toString()));
    }
  }
}
