import 'package:cat_to_do_list/core/app_router.dart';
import 'package:cat_to_do_list/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/cubit/auth_state.dart';
import 'package:cat_to_do_list/features/auth/widgets/login_buttons.dart';
import 'package:cat_to_do_list/features/auth/widgets/login_form.dart';
import 'package:cat_to_do_list/features/auth/widgets/login_header.dart';
import 'package:cat_to_do_list/features/auth/widgets/user_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showDialog(String title, String content) {
    UserAlertDialog.show(
      context: context,
      title: title,
      content: content,
      buttonText: 'OK',
      onPressed: () => context.pop(),
    );
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthCubit>().login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  void _signInWithGoogle() {
    context.read<AuthCubit>().signInWithGoogleAccount();
  }

  void _goToRegister() {
    context.push(AppRouter.kRegisterView);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              _showDialog('Login Failed', state.message);
            } else if (state is AuthAuthenticated) {
              context.go(AppRouter.kHomeView);
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 150),
                      const LoginHeader(),
                      const SizedBox(height: 20),
                      LoginForm(
                        emailController: _emailController,
                        passwordController: _passwordController,
                      ),
                      const SizedBox(height: 40),
                      LoginButtons(
                        isLoading: isLoading,
                        onLogin: _login,
                        onGoogle: _signInWithGoogle,
                        onRegister: _goToRegister,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
