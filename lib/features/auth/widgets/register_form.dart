import 'package:cat_to_do_list/features/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.validateEmail,
    required this.validatePassword,
    required this.validateConfirmPassword,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final String? Function(String?) validateEmail;
  final String? Function(String?) validatePassword;
  final String? Function(String?) validateConfirmPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: emailController,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: passwordController,
          hintText: 'Password',
          obscureText: true,
          validator: validatePassword,
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: confirmPasswordController,
          hintText: 'Confirm Password',
          obscureText: true,
          validator: validateConfirmPassword,
        ),
      ],
    );
  }
}
