import 'package:cat_to_do_list/core/routing/app_router.dart';
import 'package:cat_to_do_list/core/di/app_dependencies.dart';
import 'package:cat_to_do_list/features/auth/presentation/screens/cubit/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key, required this.dependencies});

  final AppDependencies dependencies;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(
        loginUser: dependencies.loginUser,
        logoutUser: dependencies.logoutUser,
        reloadCurrentUser: dependencies.reloadCurrentUser,
      ),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router(dependencies),
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
