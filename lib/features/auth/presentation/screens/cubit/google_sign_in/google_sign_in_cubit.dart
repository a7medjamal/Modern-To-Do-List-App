import 'package:cat_to_do_list/core/routing/app_router.dart';
import 'package:cat_to_do_list/features/auth/domain/usecases/user_google_register.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'google_sign_in_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  final SignInWithGoogle _signInWithGoogle;

  GoogleSignInCubit({required SignInWithGoogle signInWithGoogle})
    : _signInWithGoogle = signInWithGoogle,
      super(GoogleSignInInitial());

  Future<void> signInWithGoogle(BuildContext context) async {
    emit(GoogleSignInLoading());

    try {
      await _signInWithGoogle();
      emit(GoogleSignInSuccess());
      AppRouter.goToHome(context);
    } catch (e) {
      emit(GoogleSignInFailure(e.toString()));
    }
  }
}
