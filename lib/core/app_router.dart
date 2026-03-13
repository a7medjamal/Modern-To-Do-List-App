import 'package:cat_to_do_list/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/login_screen.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/register_screen.dart';
import 'package:cat_to_do_list/features/home/presentation/home_screen.dart';
import 'package:cat_to_do_list/features/tasks/presentation/screens/task_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String kHomeView = '/home';
  static const String kLoginView = '/';
  static const String kRegisterView = '/register';
  static const String kForgotPasswordView = '/forgot-password';
  // Define route patterns
  static const String kTaskDetailsBasePath = '/taskDetails';
  static const String kNewTaskPath =
      '$kTaskDetailsBasePath/new'; // Path for new task
  static const String kEditTaskPath =
      '$kTaskDetailsBasePath/:taskId'; // Path for editing task

  static final GoRouter router = GoRouter(
    initialLocation: kLoginView, // Or kHomeView if you have auth persistence
    routes: [
      GoRoute(path: kHomeView, builder: (context, state) => const HomeScreen()),
      GoRoute(path: kLoginView, builder: (context, state) => LoginScreen()),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: kForgotPasswordView,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      // Route for adding a new task (no ID)
      GoRoute(
        path: kNewTaskPath, // Use specific path for clarity
        builder:
            (context, state) => const TaskDetailsScreen(
              taskId: null,
            ), // Explicitly pass null taskId
      ),
      // Route for viewing/editing an existing task (with ID)
      GoRoute(
        path: kEditTaskPath, // Use path parameter :taskId
        builder: (context, state) {
          // Extract taskId from path parameters
          final taskId = state.pathParameters['taskId'];
          return TaskDetailsScreen(taskId: taskId); // Pass the extracted taskId
        },
      ),
    ],
    // Optional: Add error handling for routes not found
    // errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );

  // Helper methods for navigation (optional but recommended)
  static void goToHome(BuildContext context) => context.go(kHomeView);
  static void goToLogin(BuildContext context) => context.go(kLoginView);
  static void goToRegister(BuildContext context) => context.go(kRegisterView);
  static void goToForgotPassword(BuildContext context) => context.push(kForgotPasswordView);
  static void goToNewTask(BuildContext context) =>
      context.push(kNewTaskPath); // Use push to add to stack
  static void goToEditTask(BuildContext context, String taskId) =>
      context.push('$kTaskDetailsBasePath/$taskId'); // Use push
}
