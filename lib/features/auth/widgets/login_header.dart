import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Welcome Back',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
