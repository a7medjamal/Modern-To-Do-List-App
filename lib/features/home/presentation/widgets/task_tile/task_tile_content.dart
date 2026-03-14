import 'package:cat_to_do_list/features/tasks/domain/entities/task.dart';
import 'package:flutter/material.dart';

class TaskTileContent {
  TaskTileContent({required this.task});

  final Task task;

  Text get title {
    return Text(
      task.title,
      style: TextStyle(
        color: Colors.white,
        decoration:
            task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
        decorationColor: Colors.white54,
      ),
    );
  }

  Text? get subtitle {
    if (task.description.isEmpty) return null;
    return Text(
      task.description,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.white70,
        decoration:
            task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
        decorationColor: Colors.white54,
      ),
    );
  }
}
