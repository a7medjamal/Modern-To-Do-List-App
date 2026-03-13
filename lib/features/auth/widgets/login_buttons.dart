import 'package:cat_to_do_list/features/auth/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class LoginButtons extends StatelessWidget {
  const LoginButtons({
    super.key,
    required this.isLoading,
    required this.onLogin,
    required this.onGoogle,
    required this.onRegister,
  });

  final bool isLoading;
  final VoidCallback onLogin;
  final VoidCallback onGoogle;
  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: isLoading ? 'LOADING...' : 'LOGIN',
            textColor: Colors.white,
            backgroundColor: const Color(0xff7A12FF),
            onPressed: isLoading ? null : onLogin,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: 'SIGN IN WITH GOOGLE',
            textColor: Colors.white,
            backgroundColor: Colors.blue,
            onPressed: isLoading ? null : onGoogle,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: 'REGISTER NOW',
            textColor: Colors.white,
            backgroundColor: Colors.green,
            onPressed: onRegister,
          ),
        ),
      ],
    );
  }
}
