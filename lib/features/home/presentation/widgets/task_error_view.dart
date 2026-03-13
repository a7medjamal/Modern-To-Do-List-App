import 'package:flutter/material.dart';

class TaskErrorView extends StatelessWidget {
  const TaskErrorView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Error loading tasks: $message',
        style: const TextStyle(color: Colors.redAccent),
        textAlign: TextAlign.center,
      ),
    );
  }
}
