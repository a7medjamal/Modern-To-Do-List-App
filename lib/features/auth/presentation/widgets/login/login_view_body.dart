import 'package:cat_to_do_list/features/auth/presentation/widgets/custom_header.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/login/login_actions.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({
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
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 80),
              const CustomHeader(text: 'Taskify'),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [const CustomHeader(text: 'Welcome Back')],
              ),
              const SizedBox(height: 30),
              LoginForm(
                emailController: emailController,
                passwordController: passwordController,
              ),
              const SizedBox(height: 100),
              LoginActions(onLogin: onLogin, onGoogle: onGoogle),
            ],
          ),
        ),
      ),
    );
  }
}
