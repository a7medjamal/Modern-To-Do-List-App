import 'package:cat_to_do_list/features/auth/domain/usecases/send_password_reset.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final SendPasswordResetEmail _sendPasswordResetEmail;

  ResetPasswordCubit({required SendPasswordResetEmail sendPasswordResetEmail})
    : _sendPasswordResetEmail = sendPasswordResetEmail,
      super(ResetPasswordInitial());

  Future<void> resetPassword(String email) async {
    emit(ResetPasswordLoading());

    try {
      await _sendPasswordResetEmail(email);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }
}
