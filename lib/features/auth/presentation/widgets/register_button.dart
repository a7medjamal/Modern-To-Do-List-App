import 'package:cat_to_do_list/features/auth/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class RegisterButtonSection extends StatelessWidget {
  const RegisterButtonSection({
    super.key,
    required this.isLoading,
    required this.onRegister,
    required this.onBackToLogin,
  });

  final bool isLoading;
  final VoidCallback onRegister;
  final VoidCallback onBackToLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          text: isLoading ? 'LOADING...' : 'REGISTER',
          textColor: Colors.white,
          backgroundColor: Colors.green,
          onPressed: isLoading ? null : onRegister,
        ),
        const SizedBox(height: 12),
        CustomButton(
          text: 'Back to Login',
          textColor: Colors.white,
          backgroundColor: const Color(0xff7A12FF),
          onPressed: isLoading ? null : onBackToLogin,
        ),
      ],
    );
  }
}
