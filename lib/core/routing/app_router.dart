import 'package:cat_to_do_list/core/di/app_dependencies.dart';
import 'package:cat_to_do_list/core/routing/go_router_refresh_stream.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/google_sign_in/google_sign_in_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/register/register_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/reset_password/reset_password_cubit.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/login_screen.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/register_screen.dart';
import 'package:cat_to_do_list/features/home/presentation/home_screen.dart';
import 'package:cat_to_do_list/features/tasks/presentation/cubit/task_cubit.dart';
import 'package:cat_to_do_list/features/tasks/presentation/screens/task_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String kHomeView = '/home';
  static const String kLoginView = '/login';
  static const String kRegisterView = '/register';
  static const String kForgotPasswordView = '/forgot-password';

  static const String kTaskDetailsBasePath = '/taskDetails';
  static const String kNewTaskPath = '$kTaskDetailsBasePath/new';
  static const String kEditTaskPath = '$kTaskDetailsBasePath/:taskId';

  static GoRouter router(AppDependencies dependencies) {
    return GoRouter(
      initialLocation: kLoginView,
      refreshListenable: GoRouterRefreshStream(
        FirebaseAuth.instance.authStateChanges(),
      ),
      routes: [
        GoRoute(
          path: kLoginView,
          builder: (context, state) {
            return BlocProvider<GoogleSignInCubit>(
              create:
                  (_) => GoogleSignInCubit(
                    signInWithGoogle: dependencies.signInWithGoogle,
                  ),
              child: const LoginScreen(),
            );
          },
        ),
        GoRoute(
          path: kRegisterView,
          builder: (context, state) {
            return BlocProvider<RegisterCubit>(
              create:
                  (_) => RegisterCubit(
                    signUpUser: dependencies.signUpUser,
                    sendEmailVerification: dependencies.sendEmailVerification,
                  ),
              child: const RegisterScreen(),
            );
          },
        ),
        GoRoute(
          path: kForgotPasswordView,
          builder: (context, state) {
            return BlocProvider<ResetPasswordCubit>(
              create:
                  (_) => ResetPasswordCubit(
                    sendPasswordResetEmail: dependencies.sendPasswordResetEmail,
                  ),
              child: const ForgotPasswordScreen(),
            );
          },
        ),
        ShellRoute(
          builder: (context, state, child) {
            return BlocProvider<TaskCubit>(
              create:
                  (_) => TaskCubit(
                    addTask: dependencies.addTask,
                    updateTask: dependencies.updateTask,
                    deleteTask: dependencies.deleteTask,
                    getTaskById: dependencies.getTaskById,
                    getTasks: dependencies.getTasks,
                  )..loadTasks(),
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: kHomeView,
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: kNewTaskPath,
              builder: (context, state) => const TaskDetailsScreen(),
            ),
            GoRoute(
              path: kEditTaskPath,
              builder: (context, state) {
                final taskId = state.pathParameters['taskId'];
                return TaskDetailsScreen(taskId: taskId);
              },
            ),
          ],
        ),
      ],
    );
  }

  static void goToHome(BuildContext context) => context.go(kHomeView);

  static void goToLogin(BuildContext context) => context.go(kLoginView);

  static void goToRegister(BuildContext context) => context.push(kRegisterView);

  static void goToForgotPassword(BuildContext context) =>
      context.push(kForgotPasswordView);

  static void goToNewTask(BuildContext context) => context.push(kNewTaskPath);

  static void goToEditTask(BuildContext context, String taskId) {
    context.push('$kTaskDetailsBasePath/$taskId');
  }
}
