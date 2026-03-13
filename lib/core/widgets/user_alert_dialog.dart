import 'package:flutter/material.dart';

class UserAlertDialog extends StatelessWidget {
  const UserAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.buttonText = 'OK',
    this.onPressed,
  });

  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onPressed;

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
    bool barrierDismissible = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder:
          (_) => UserAlertDialog(
            title: title,
            message: message,
            buttonText: buttonText,
            onPressed: onPressed,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(title, style: Theme.of(context).textTheme.titleLarge),
      content: Text(message, style: Theme.of(context).textTheme.bodyMedium),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onPressed?.call();
          },
          child: Text(buttonText),
        ),
      ],
    );
  }
}
