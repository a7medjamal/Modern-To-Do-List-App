import 'package:cat_to_do_list/core/routing/app_router.dart';
import 'package:cat_to_do_list/core/widgets/user_alert_dialog.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/auth/auth_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/auth/auth_state.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/google_sign_in/google_sign_in_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/custom_header.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/login_buttons.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/login_form.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            UserAlertDialog(
              title: 'Login Failed',
              message: state.message,
              onPressed: () => context.pop(),
            );
          } else if (state is AuthAuthenticated) {
            AppRouter.goToHome(context);
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
                    const CustomHeader(text: 'Welcome Back'),
                    const SizedBox(height: 20),
                    LoginForm(
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                    const SizedBox(height: 40),
                    LoginButtons(
                      isLoading: isLoading,
                      onLogin:
                          () => context.read<AuthCubit>().login(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          ),
                      onGoogle:
                          () => context
                              .read<GoogleSignInCubit>()
                              .signInWithGoogle(context),
                      onRegister: () => AppRouter.goToRegister(context),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
