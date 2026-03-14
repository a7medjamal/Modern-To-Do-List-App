import 'package:cat_to_do_list/core/routing/app_router.dart';
import 'package:cat_to_do_list/core/widgets/user_alert_dialog.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/auth/auth_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/auth/auth_state.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/google_sign_in/google_sign_in_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/google_sign_in/google_sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginListeners extends StatelessWidget {
  const LoginListeners({super.key, required this.child});

  final Widget child;

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder:
          (dialogContext) => UserAlertDialog(
            title: title,
            message: message,
            onPressed: () {
              Navigator.of(dialogContext, rootNavigator: true).pop();
            },
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
              context.go(AppRouter.kHomeView);
            } else if (state is AuthFailure) {
              _showDialog(context, 'Login Failed', state.message);
            }
          },
        ),
        BlocListener<GoogleSignInCubit, GoogleSignInState>(
          listener: (context, state) {
            if (state is GoogleSignInSuccess) {
              context.go(AppRouter.kHomeView);
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
