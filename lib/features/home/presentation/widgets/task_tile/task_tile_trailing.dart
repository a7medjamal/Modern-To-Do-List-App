import 'package:cat_to_do_list/features/tasks/domain/entities/task.dart';
import 'package:cat_to_do_list/features/tasks/presentation/cubit/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskTileTrailing extends StatelessWidget {
  const TaskTileTrailing({
    super.key,
    required this.task,
    required this.isCompletedList,
  });

  final Task task;
  final bool isCompletedList;

  @override
  Widget build(BuildContext context) {
    if (isCompletedList) {
      return IconButton(
        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
        onPressed: () {
          context.read<TaskCubit>().deleteTask(task.id);
        },
      );
    }

    return const Icon(Icons.chevron_right, color: Colors.white54);
  }
}
