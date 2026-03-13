import 'package:cat_to_do_list/core/app_router.dart';
import 'package:cat_to_do_list/core/di/app_dependencies.dart';
import 'package:cat_to_do_list/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:cat_to_do_list/features/tasks/presentation/screens/cubit/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToDoApp extends StatelessWidget {
  final AppDependencies dependencies;

  const ToDoApp({super.key, required this.dependencies});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => AuthCubit(
                loginUser: dependencies.loginUser,
                signUpUser: dependencies.signUpUser,
                logoutUser: dependencies.logoutUser,
                signInWithGoogle: dependencies.signInWithGoogle,
              ),
        ),
        BlocProvider(
          create:
              (_) => TaskCubit(
                addTask: dependencies.addTask,
                updateTask: dependencies.updateTask,
                deleteTask: dependencies.deleteTask,
                getTaskById: dependencies.getTaskById,
                getTasks: dependencies.getTasks,
              )..loadTasks(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff1A1A2F),
          fontFamily: 'Roboto',
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xff242443)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
