import 'package:cat_to_do_list/features/home/presentation/widgets/expandable_drawer_button.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/task_tile/task_tile_list.dart';
import 'package:cat_to_do_list/features/tasks/domain/entities/task.dart';
import 'package:flutter/material.dart';

class TaskListSection extends StatelessWidget {
  const TaskListSection({
    super.key,
    required this.label,
    required this.tasks,
    required this.initiallyExpanded,
    this.isCompletedList = false,
  });

  final String label;
  final List<Task> tasks;
  final bool initiallyExpanded;
  final bool isCompletedList;

  @override
  Widget build(BuildContext context) {
    return ExpandableDrawerButton(
      label: label,
      initiallyExpanded: initiallyExpanded,
      children: [
        TaskListSectionContent(tasks: tasks, isCompletedList: isCompletedList),
      ],
    );
  }
}

class TaskListSectionContent extends StatelessWidget {
  const TaskListSectionContent({
    super.key,
    required this.tasks,
    this.isCompletedList = false,
  });

  final List<Task> tasks;
  final bool isCompletedList;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text('No tasks here.', style: TextStyle(color: Colors.white54)),
      );
    }

    return Column(
      children:
          tasks
              .map(
                (task) =>
                    TaskTile(task: task, isCompletedList: isCompletedList),
              )
              .toList(),
    );
  }
}
