import 'package:flutter/material.dart';

class UserAlertDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String content,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                onPressed();
              },
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }
}
