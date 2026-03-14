import 'package:cat_to_do_list/core/routing/app_router.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/auth/auth_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/register/register_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/register/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterListeners extends StatelessWidget {
  const RegisterListeners({super.key, required this.child});

  final Widget child;

  void _showDialog(
    BuildContext context,
    String title,
    String message,
    Widget Function(BuildContext dialogContext) actionBuilder,
  ) {
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [actionBuilder(dialogContext)],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) async {
        if (state is RegisterFailure) {
          _showDialog(
            context,
            'Registration Failed',
            state.message,
            (dialogContext) => TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('OK'),
            ),
          );
        } else if (state is RegisterSuccess) {
          _showDialog(
            context,
            'Success',
            state.message,
            (dialogContext) => TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await context.read<AuthCubit>().logout();

                if (!context.mounted) return;
                context.go(AppRouter.kLoginView);
              },
              child: const Text('OK'),
            ),
          );
        }
      },
      child: child,
    );
  }
}
