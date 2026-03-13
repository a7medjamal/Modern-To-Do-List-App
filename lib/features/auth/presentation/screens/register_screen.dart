import 'package:cat_to_do_list/core/routing/app_router.dart';
import 'package:cat_to_do_list/core/utils/validators.dart';
import 'package:cat_to_do_list/core/widgets/user_alert_dialog.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/auth/auth_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/auth/auth_state.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/register/register_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/custom_header.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/register_button.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Confirm password is required';
    }

    if (value.trim() != _passwordController.text.trim()) {
      return 'Passwords do not match';
    }

    return null;
  }

  void _register() {
    if (!_formKey.currentState!.validate()) return;

    context.read<RegisterCubit>().registerWithEmailAndPassword(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            UserAlertDialog(
              title: 'Registration Failed',
              message: state.message,
              onPressed: () => context.pop(),
            );
          } else if (state is AuthAuthenticated) {
            UserAlertDialog(
              title: 'Success',
              message:
                  'Registered successfully!\nPlease check your email to verify your account before logging in.',
              onPressed: () => context.go(AppRouter.kLoginView),
            );
          }
        },
        builder: (context, state) {
          final bool isLoading = state is AuthLoading;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 150),
                    const CustomHeader(text: 'Create Account'),
                    const SizedBox(height: 20),
                    RegisterForm(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      validateEmail: Validators.validateEmail,
                      validatePassword: Validators.validatePassword,
                      validateConfirmPassword: _validateConfirmPassword,
                    ),
                    const SizedBox(height: 30),
                    RegisterButtonSection(
                      isLoading: isLoading,
                      onRegister: _register,
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
