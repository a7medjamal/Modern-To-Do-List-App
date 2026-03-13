import 'package:flutter/material.dart';

class EmptyTasksView extends StatelessWidget {
  const EmptyTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No tasks yet!\nTap '+' to add one.",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white54, fontSize: 16),
      ),
    );
  }
}
