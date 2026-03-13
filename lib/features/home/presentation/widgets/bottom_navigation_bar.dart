import 'package:cat_to_do_list/core/app_router.dart';
import 'package:cat_to_do_list/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/bottom_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (index == 3) {
      _showLogoutSheet();
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // go to menu screen when available
        break;
      case 1:
        context.go(AppRouter.kHomeView);
        break;
      case 2:
        // go to calendar screen when available
        break;
    }
  }

  void _showLogoutSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Are you sure you want to log out?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                onPressed: () async {
                  Navigator.of(sheetContext).pop();
                  await context.read<AuthCubit>().logout();
                  if (mounted) {
                    context.go(AppRouter.kLoginView);
                  }
                },
                child: const Text('Log Out'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.of(sheetContext).pop(),
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(18),
        topRight: Radius.circular(18),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: const Color(0xff242443),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color(0xff777E99),
          selectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            buildNavItem(
              'assets/icons/menu_icon.svg',
              'Menu',
              0,
              _selectedIndex,
              () => _onItemTapped(0),
            ),
            buildNavItem(
              'assets/icons/tasks_icon.svg',
              'Tasks',
              1,
              _selectedIndex,
              () => _onItemTapped(1),
            ),
            buildNavItem(
              'assets/icons/calendar_icon.svg',
              'Calendar',
              2,
              _selectedIndex,
              () => _onItemTapped(2),
            ),
            buildNavItem(
              'assets/icons/user_icon.svg',
              'Mine',
              3,
              _selectedIndex,
              () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
