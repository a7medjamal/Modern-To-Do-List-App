import 'package:cat_to_do_list/features/auth/domain/usecases/login_user.dart';
import 'package:cat_to_do_list/features/auth/domain/usecases/signup_user.dart';
import 'package:cat_to_do_list/features/auth/domain/usecases/send_email_verification.dart';
import 'package:cat_to_do_list/features/auth/domain/usecases/send_password_reset.dart';
import 'package:cat_to_do_list/features/auth/domain/usecases/user_google_register.dart';
import 'package:cat_to_do_list/features/auth/domain/usecases/user_logout.dart';
import 'package:cat_to_do_list/features/auth/presentation/cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUser loginUser;
  final SignUpUser signUpUser;
  final LogoutUser logoutUser;
  final SignInWithGoogle signInWithGoogle;
  final SendEmailVerification sendEmailVerification;
  final SendPasswordResetEmail sendPasswordResetEmail;

  AuthCubit({
    required this.loginUser,
    required this.signUpUser,
    required this.logoutUser,
    required this.signInWithGoogle,
    required this.sendEmailVerification,
    required this.sendPasswordResetEmail,
  }) : super(const AuthInitial());

  Future<void> login(String email, String password) async {
    emit(const AuthLoading());

    try {
      await loginUser(email, password);
      
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        emit(const AuthFailure('Please verify your email to log in.'));
      } else {
        emit(const AuthAuthenticated());
      }
    } catch (e) {
      emit(AuthFailure(_mapErrorMessage(e)));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(const AuthLoading());

    try {
      await signUpUser(email, password);
      await sendEmailVerification();
      emit(const AuthAuthenticated());
    } catch (e) {
      emit(AuthFailure(_mapErrorMessage(e)));
    }
  }

  Future<void> signInWithGoogleAccount() async {
    emit(const AuthLoading());

    try {
      await signInWithGoogle();
      emit(const AuthAuthenticated());
    } catch (e) {
      final message = _mapErrorMessage(e);

      if (message == 'cancelled') {
        emit(const AuthInitial());
        return;
      }

      emit(AuthFailure(message));
    }
  }

  Future<void> logout() async {
    emit(const AuthLoading());

    try {
      await logoutUser();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(_mapErrorMessage(e)));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(const AuthLoading());

    try {
      await sendPasswordResetEmail(email);
      emit(const AuthInitial());
    } catch (e) {
      emit(AuthFailure(_mapErrorMessage(e)));
    }
  }

  String _mapErrorMessage(Object error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          return 'Invalid email address.';
        case 'user-disabled':
          return 'This account has been disabled.';
        case 'user-not-found':
          return 'No user found for this email.';
        case 'wrong-password':
        case 'invalid-credential':
          return 'Incorrect email or password.';
        case 'email-already-in-use':
          return 'This email is already in use.';
        case 'weak-password':
          return 'Password is too weak.';
        case 'network-request-failed':
          return 'Please check your internet connection.';
        default:
          return error.message ?? 'Authentication failed.';
      }
    }

    final text = error.toString();

    if (text.contains('cancelled') ||
        text.contains('canceled') ||
        text.contains('Google sign-in was cancelled')) {
      return 'cancelled';
    }

    if (text.contains('ApiException: 10')) {
      return 'Google Sign-In configuration error. Check SHA-1, SHA-256, package name, and google-services.json.';
    }

    if (text.contains('network_error') ||
        text.contains('SocketException') ||
        text.contains('Failed host lookup')) {
      return 'Please check your internet connection.';
    }

    return text.replaceFirst('Exception: ', '');
  }
}
