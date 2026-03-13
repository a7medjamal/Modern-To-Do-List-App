

import 'package:cat_to_do_list/core/app_router.dart';
import 'package:cat_to_do_list/features/auth/widgets/user_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> signInWithEmailAndPassword(
  String email,
  String password,
  BuildContext context,
) async {
  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    GoRouter.of(context).pop();
    UserAlertDialog.show(
      context: context,
      title: 'Success',
      content: 'Welcome back ${userCredential.user!.email}',
      buttonText: 'OK',
      onPressed: () {
        GoRouter.of(context).replace(AppRouter.kHomeView);
      },
    );
  } catch (e) {
    GoRouter.of(context).pop();
    String errorMessage = 'Failed to sign in. Please try again.';
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email format.';
          break;
        default:
          errorMessage = e.message ?? errorMessage;
      }
    }

    if (kDebugMode) {
      print('Failed to sign in: $e');
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
