import 'package:cat_to_do_list/core/routing/app_router.dart';
import 'package:cat_to_do_list/core/utils/validators.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: emailController,
          hintText: 'Email',
          validator: Validators.validateEmail,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          controller: passwordController,
          hintText: 'Password',
          obscureText: true,
          validator: Validators.validatePassword,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => context.push(AppRouter.kForgotPasswordView),
            child: const Text(
              'Forgot Password?',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
