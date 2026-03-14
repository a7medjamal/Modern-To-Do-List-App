import 'package:cat_to_do_list/features/auth/domain/usecases/login_user.dart';
import 'package:cat_to_do_list/features/auth/domain/usecases/user_logout.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        emit(const AuthFailure('Login failed. Please try again.'));
        return;
      }

      if (!user.emailVerified) {
        await _logoutUser();
        emit(const AuthFailure('Please verify your email before signing in.'));
        return;
      }

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
