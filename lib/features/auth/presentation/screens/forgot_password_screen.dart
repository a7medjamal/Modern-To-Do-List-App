import 'package:cat_to_do_list/core/widgets/user_alert_dialog.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/reset_password/reset_password_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/reset_password/reset_password_state.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/custom_button.dart';
import 'package:cat_to_do_list/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ResetPasswordCubit>().resetPassword(
      _emailController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordFailure) {
              UserAlertDialog(
                title: 'Reset Failed',
                message: state.message,
                onPressed: () => context.pop(),
              );
            } else if (state is ResetPasswordSuccess) {
              UserAlertDialog(
                title: 'Email Sent',
                message:
                    'If an account with that email exists, a password reset link has been sent.',
                onPressed: () {
                  context.pop();
                  context.pop();
                },
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is ResetPasswordLoading;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 50),
                      const Text(
                        'Reset Your Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Enter your email address to receive a password reset link.',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 50),
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email is required';
                          }
                          final emailRegex = RegExp(
                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                          );
                          if (!emailRegex.hasMatch(value.trim())) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        text: 'Send Reset Link',
                        backgroundColor: Colors.deepPurpleAccent,
                        textColor: Colors.white,
                        onPressed: isLoading ? null : _resetPassword,
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
