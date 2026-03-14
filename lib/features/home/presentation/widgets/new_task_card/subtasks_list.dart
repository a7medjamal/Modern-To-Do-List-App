import 'package:flutter/material.dart';
import 'subtask_item.dart';

class SubTasksList extends StatelessWidget {
  const SubTasksList({
    super.key,
    required this.subTasks,
    required this.onRemove,
  });

  final List<String> subTasks;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    if (subTasks.isEmpty) return const SizedBox();

    return Column(
      children: List.generate(
        subTasks.length,
        (index) =>
            SubTaskItem(text: subTasks[index], onRemove: () => onRemove(index)),
      ),
    );
  }
}
