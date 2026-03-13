import 'package:cat_to_do_list/features/tasks/presentation/widgets/task_input_decoration.dart';
import 'package:flutter/material.dart';

class TaskDescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const TaskDescriptionField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 4,
      style: const TextStyle(color: Colors.white),
      decoration: taskInputDecoration('Description (Optional)'),
    );
  }
}
