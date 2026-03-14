import 'package:cat_to_do_list/features/tasks/domain/entities/task.dart';
import 'package:cat_to_do_list/features/tasks/presentation/cubit/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCheckbox extends StatelessWidget {
  const TaskCheckbox({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: task.isCompleted,
      onChanged: (value) {
        if (value == null) return;

        final updatedTask = task.copyWith(isCompleted: value);
        context.read<TaskCubit>().updateTask(updatedTask);
      },
      checkColor: Colors.white,
      activeColor: Colors.deepPurpleAccent,
      side: const BorderSide(color: Colors.white54),
    );
  }
}
