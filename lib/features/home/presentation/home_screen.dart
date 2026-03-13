import 'package:cat_to_do_list/core/app_router.dart';
import 'package:cat_to_do_list/core/utils/widgets/custom_app_bar.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/create_new_task_button.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/home_body.dart';
import 'package:cat_to_do_list/features/tasks/presentation/cubit/task_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName =
        user?.displayName?.trim().isNotEmpty == true
            ? user!.displayName!
            : user?.email ?? 'User';

    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              pfpPath: 'assets/icons/profile_icon.svg',
              pName: userName,
              iconPath: 'assets/icons/home_screen_search_icon.svg',
            ),
            const SizedBox(height: 10),
            const Expanded(child: HomeBody()),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 65),
        child: CreateNewTaskButton(
          onPressed: () {
            AppRouter.goToNewTask(context);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
