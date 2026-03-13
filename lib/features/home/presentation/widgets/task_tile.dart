import 'package:cat_to_do_list/core/app_router.dart';
import 'package:cat_to_do_list/features/tasks/domain/entities/task.dart';
import 'package:cat_to_do_list/features/tasks/presentation/cubit/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, this.isCompletedList = false});

  final Task task;
  final bool isCompletedList;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (bool? value) {
          if (value != null) {
            final updatedTask = task.copyWith(isCompleted: value);
            context.read<TaskCubit>().updateTask(updatedTask);
          }
        },
        checkColor: Colors.white,
        activeColor: Colors.deepPurpleAccent,
        side: const BorderSide(color: Colors.white54),
      ),
      title: Text(
        task.title,
        style: TextStyle(
          color: Colors.white,
          decoration:
              task.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
          decorationColor: Colors.white54,
        ),
      ),
      subtitle:
          task.description.isNotEmpty
              ? Text(
                task.description,
                style: TextStyle(
                  color: Colors.white70,
                  decoration:
                      task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                  decorationColor: Colors.white54,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
              : null,
      trailing:
          isCompletedList
              ? IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () {
                  context.read<TaskCubit>().deleteTask(task.id);
                },
              )
              : const Icon(Icons.chevron_right, color: Colors.white54),
      onTap: () {
        AppRouter.goToEditTask(context, task.id);
      },
      dense: true,
    );
  }
}
