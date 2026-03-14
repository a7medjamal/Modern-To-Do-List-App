import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/register/register_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/register/register_state.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/register_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterActions extends StatelessWidget {
  const RegisterActions({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  void _register(BuildContext context) {
    if (!(formKey.currentState?.validate() ?? false)) return;

    context.read<RegisterCubit>().registerWithEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final isLoading = state is RegisterLoading;

        return RegisterButtonSection(
          isLoading: isLoading,
          onRegister: () => _register(context),
        );
      },
    );
  }
}
