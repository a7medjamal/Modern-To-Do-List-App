import 'package:cat_to_do_list/features/auth/domain/usecases/signup_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final SignUpUser _signUpUser;

  RegisterCubit({required SignUpUser signUpUser})
    : _signUpUser = signUpUser,
      super(RegisterInitial());

  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    emit(RegisterLoading());
    try {
      await _signUpUser(email, password);
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
