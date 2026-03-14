import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/auth/auth_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/google_sign_in/google_sign_in_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/login/login_content.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/login/login_listeners.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void _onLoginPressed() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<AuthCubit>().login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  void _onGooglePressed() {
    context.read<GoogleSignInCubit>().signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return LoginListeners(
      child: Scaffold(
        body: LoginContent(
          formKey: _formKey,
          emailController: _emailController,
          passwordController: _passwordController,
          onLogin: _onLoginPressed,
          onGoogle: _onGooglePressed,
        ),
      ),
    );
  }
}
