import 'package:flutter/material.dart';

class TaskDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskDetailsAppBar({super.key, required this.isExistingTask});

  final bool isExistingTask;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: const Color(0xFF242443),
      elevation: 0,
      title: Text(
        isExistingTask ? 'Edit Task' : 'New Task',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
