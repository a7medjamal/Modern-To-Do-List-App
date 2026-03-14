import 'package:cat_to_do_list/core/routing/app_router.dart';
import 'package:cat_to_do_list/features/tasks/domain/entities/task.dart';
import 'package:flutter/material.dart';
import 'task_checkbox.dart';
import 'task_tile_content.dart';
import 'task_tile_trailing.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    this.isCompletedList = false,
  });

  final Task task;
  final bool isCompletedList;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TaskCheckbox(task: task),
      title: TaskTileContent(task: task).title,
      subtitle: TaskTileContent(task: task).subtitle,
      trailing: TaskTileTrailing(
        task: task,
        isCompletedList: isCompletedList,
      ),
      dense: true,
      onTap: () => AppRouter.goToEditTask(context, task.id),
    );
  }
}