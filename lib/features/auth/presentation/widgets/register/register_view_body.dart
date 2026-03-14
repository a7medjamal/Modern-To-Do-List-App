import 'package:cat_to_do_list/core/utils/validators.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/custom_header.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'register_actions.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Confirm password is required';
    }

    if (value.trim() != passwordController.text.trim()) {
      return 'Passwords do not match';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 100),
              const CustomHeader(text: 'Create Account'),
              const SizedBox(height: 100),
              RegisterForm(
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
                validateEmail: Validators.validateEmail,
                validatePassword: Validators.validatePassword,
                validateConfirmPassword: _validateConfirmPassword,
              ),
              const SizedBox(height: 100),
              RegisterActions(
                formKey: formKey,
                emailController: emailController,
                passwordController: passwordController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
