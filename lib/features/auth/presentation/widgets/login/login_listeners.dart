import 'package:cat_to_do_list/core/routing/app_router.dart';
import 'package:cat_to_do_list/core/widgets/user_alert_dialog.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/auth/auth_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/auth/auth_state.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/google_sign_in/google_sign_in_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/google_sign_in/google_sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginListeners extends StatelessWidget {
  const LoginListeners({super.key, required this.child});

  final Widget child;

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder:
          (_) => UserAlertDialog(
            title: title,
            message: message,
            onPressed: () => Navigator.pop(context),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              AppRouter.goToHome(context);
            } else if (state is AuthFailure) {
              _showDialog(context, 'Login Failed', state.message);
            }
          },
        ),
        BlocListener<GoogleSignInCubit, GoogleSignInState>(
          listener: (context, state) {
            if (state is GoogleSignInSuccess) {
              AppRouter.goToHome(context);
            } else if (state is GoogleSignInFailure) {
              _showDialog(context, 'Google Sign In Failed', state.message);
            }
          },
        ),
      ],
      child: child,
    );
  }
}
