import 'package:cat_to_do_list/features/auth/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class RegisterButtonSection extends StatelessWidget {
  const RegisterButtonSection({
    super.key,
    required this.isLoading,
    required this.onRegister,
  });

  final bool isLoading;
  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        text: isLoading ? 'LOADING...' : 'REGISTER',
        textColor: Colors.white,
        backgroundColor: Colors.green,
        onPressed: isLoading ? null : onRegister,
      ),
    );
  }
}
