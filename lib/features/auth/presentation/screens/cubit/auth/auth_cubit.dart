import 'package:cat_to_do_list/features/auth/domain/usecases/login_user.dart';
import 'package:cat_to_do_list/features/auth/domain/usecases/user_logout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUser _loginUser;
  final LogoutUser _logoutUser;

  AuthCubit({required LoginUser loginUser, required LogoutUser logoutUser})
    : _loginUser = loginUser,
      _logoutUser = logoutUser,
      super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      await _loginUser(email, password);
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await _logoutUser();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
