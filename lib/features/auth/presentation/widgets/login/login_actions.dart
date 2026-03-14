import 'package:cat_to_do_list/core/routing/app_router.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/auth/auth_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/auth/auth_state.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/google_sign_in/google_sign_in_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/google_sign_in/google_sign_in_state.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginActions extends StatelessWidget {
  const LoginActions({
    super.key,
    required this.onLogin,
    required this.onGoogle,
  });

  final VoidCallback onLogin;
  final VoidCallback onGoogle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<GoogleSignInCubit, GoogleSignInState>(
          builder: (context, googleState) {
            return LoginButtons(
              isLoading:
                  authState is AuthLoading ||
                  googleState is GoogleSignInLoading,
              onLogin: onLogin,
              onGoogle: onGoogle,
              onRegister: () => context.push(AppRouter.kRegisterView),
            );
          },
        );
      },
    );
  }
}
