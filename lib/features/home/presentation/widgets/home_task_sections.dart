import 'package:cat_to_do_list/features/home/presentation/widgets/expandable_drawer_button.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/task_list_section.dart';
import 'package:cat_to_do_list/features/tasks/domain/entities/task.dart';
import 'package:flutter/material.dart';

class HomeTaskSections extends StatelessWidget {
  const HomeTaskSections({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    final todayTasks =
        tasks
            .where(
              (task) =>
                  !task.isCompleted &&
                  task.timestamp.isAfter(today) &&
                  task.timestamp.isBefore(tomorrow),
            )
            .toList();

    final previousTasks =
        tasks
            .where(
              (task) => !task.isCompleted && task.timestamp.isBefore(today),
            )
            .toList();

    final completedTasks = tasks.where((task) => task.isCompleted).toList();

    final tasksByCategory = <String, List<Task>>{};
    for (final task in tasks.where((task) => !task.isCompleted)) {
      (tasksByCategory[task.category] ??= []).add(task);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 120, left: 16, right: 16),
      child: Column(
        children: [
          if (previousTasks.isNotEmpty) ...[
            TaskListSection(
              label: 'Previous Tasks (${previousTasks.length})',
              tasks: previousTasks,
              initiallyExpanded: false,
            ),
            const SizedBox(height: 15),
          ],
          if (todayTasks.isNotEmpty) ...[
            TaskListSection(
              label: 'Today Tasks (${todayTasks.length})',
              tasks: todayTasks,
              initiallyExpanded: true,
            ),
            const SizedBox(height: 15),
          ],
          if (tasksByCategory.isNotEmpty) ...[
            ExpandableDrawerButton(
              label: 'Categories',
              initiallyExpanded: false,
              children:
                  tasksByCategory.entries.map((entry) {
                    return ExpansionTile(
                      title: Text(
                        '${entry.key} (${entry.value.length})',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      iconColor: Colors.white54,
                      collapsedIconColor: Colors.white54,
                      children: [TaskListSectionContent(tasks: entry.value)],
                    );
                  }).toList(),
            ),
            const SizedBox(height: 15),
          ],
          if (completedTasks.isNotEmpty) ...[
            TaskListSection(
              label: 'Completed Tasks (${completedTasks.length})',
              tasks: completedTasks,
              initiallyExpanded: false,
              isCompletedList: true,
            ),
            const SizedBox(height: 15),
          ],
        ],
      ),
    );
  }
}
