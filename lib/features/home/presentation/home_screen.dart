import 'package:cat_to_do_list/core/routing/app_router.dart';
import 'package:cat_to_do_list/core/widgets/custom_app_bar.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/create_new_task_button.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/home_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _getUserName() {
    final user = FirebaseAuth.instance.currentUser;

    final displayName = user?.displayName?.trim();
    if (displayName != null && displayName.isNotEmpty) {
      return displayName;
    }

    final email = user?.email?.trim();
    if (email != null && email.isNotEmpty) {
      return email;
    }

    return 'User';
  }

  @override
  Widget build(BuildContext context) {
    final userName = _getUserName();

    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 65),
        child: CreateNewTaskButton(
          onPressed: () => context.push(AppRouter.kNewTaskPath),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
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
    );
  }
}
