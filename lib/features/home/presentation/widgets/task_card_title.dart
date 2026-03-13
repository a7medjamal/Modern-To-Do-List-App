import 'package:flutter/material.dart';

class TaskCardTitle extends StatelessWidget {
  const TaskCardTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Create New Task',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}