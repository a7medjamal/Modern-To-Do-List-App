
import 'package:cat_to_do_list/core/app_router.dart';
import 'package:cat_to_do_list/features/auth/widgets/user_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> registerWithEmailAndPassword(
  String email,
  String password,
  String confirmPassword,
  BuildContext context,
) async {
  try {
    if (password != confirmPassword) {
      UserAlertDialog.show(
        context: context,
        title: 'Error',
        content: 'Passwords do not match.',
        buttonText: 'OK',
        onPressed: () {},
      );

      return;
    }

    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserAlertDialog.show(
      context: context,
      title: 'Success',
      content: 'Registered successfully! \nLogin now!',
      buttonText: 'OK',
      onPressed: () {
        GoRouter.of(context).push(AppRouter.kLoginView);
      },
    );
  } catch (e) {
    String errorMessage = 'Something went wrong. Please try again.';
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already registered.';
          break;
        case 'weak-password':
          errorMessage = 'Password should be at least 6 characters.';
          break;
        case 'invalid-email':
          errorMessage = 'Please enter a valid email address.';
          break;
        default:
          errorMessage = e.message ?? errorMessage;
      }
    }
    if (kDebugMode) {
      print('Failed to register: $e');
    }
    UserAlertDialog.show(
      context: context,
      title: 'Error',
      content: errorMessage,
      buttonText: 'OK',
      onPressed: () {},
    );
  }
}
