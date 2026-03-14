import 'package:cat_to_do_list/core/routing/app_router.dart';
import 'package:cat_to_do_list/core/widgets/user_alert_dialog.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/auth/auth_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterListeners extends StatelessWidget {
  const RegisterListeners({super.key, required this.child});

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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          _showDialog(context, 'Registration Failed', state.message);
        }

        if (state is AuthAuthenticated) {
          showDialog(
            context: context,
            builder:
                (_) => UserAlertDialog(
                  title: 'Success',
                  message:
                      'Registered successfully!\nPlease check your email to verify your account before logging in.',
                  onPressed: () => context.go(AppRouter.kLoginView),
                ),
          );
        }
      },
      child: child,
    );
  }
}
