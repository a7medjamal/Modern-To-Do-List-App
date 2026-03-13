import 'package:cat_to_do_list/features/home/presentation/widgets/subtask_text_field.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/task_actions.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/task_card_title.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/title_field.dart';
import 'package:flutter/material.dart';

class CreateNewTaskCard extends StatefulWidget {
  const CreateNewTaskCard({super.key});

  @override
  State<CreateNewTaskCard> createState() => _CreateNewTaskCardState();
}

class _CreateNewTaskCardState extends State<CreateNewTaskCard> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subTaskController = TextEditingController();

  final List<String> _subTasks = [];

  void _addSubTask() {
    final text = _subTaskController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      _subTasks.add(text);
      _subTaskController.clear();
    });
  }

  void _removeSubTask(int index) {
    setState(() {
      _subTasks.removeAt(index);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subTaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1C35),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xff7A12FF)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TaskCardTitle(),
          const SizedBox(height: 16),

          TitleField(controller: _titleController),

          const SizedBox(height: 16),

          SubTaskTextField(
            controller: _subTaskController,
            onAddSubTask: _addSubTask,
          ),

          const SizedBox(height: 16),

          if (_subTasks.isNotEmpty)
            Column(
              children: List.generate(_subTasks.length, (index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF242443),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _subTasks[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _removeSubTask(index),
                        icon: const Icon(Icons.close, color: Colors.redAccent),
                      ),
                    ],
                  ),
                );
              }),
            ),

          const SizedBox(height: 30),
          const TaskActions(),
        ],
      ),
    );
  }
}
