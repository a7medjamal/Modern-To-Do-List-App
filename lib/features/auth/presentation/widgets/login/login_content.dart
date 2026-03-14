import 'package:cat_to_do_list/features/auth/presentation/widgets/custom_header.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/login/login_actions.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
    required this.onGoogle,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final VoidCallback onGoogle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 150),
              const CustomHeader(text: 'Welcome Back'),
              const SizedBox(height: 20),
              LoginForm(
                emailController: emailController,
                passwordController: passwordController,
              ),
              const SizedBox(height: 40),
              LoginActions(onLogin: onLogin, onGoogle: onGoogle),
            ],
          ),
        ),
      ),
    );
  }
}
