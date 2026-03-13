import 'package:flutter/material.dart';

class TaskActionButtons extends StatelessWidget {
  final bool isExistingTask;
  final VoidCallback onSave;
  final VoidCallback onDelete;

  const TaskActionButtons({
    super.key,
    required this.isExistingTask,
    required this.onSave,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: onSave,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          child: Text(isExistingTask ? 'Update Task' : 'Save Task'),
        ),
        if (isExistingTask) ...[
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onDelete,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text('Delete Task'),
          ),
        ],
      ],
    );
  }
}
