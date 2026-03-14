import 'package:cat_to_do_list/features/home/presentation/cubit/create_task_cubit.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/subtask_text_field.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/task_actions.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/task_card_title.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/task_title_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'subtasks_list.dart';

class CreateNewTaskCard extends StatefulWidget {
  const CreateNewTaskCard({super.key});

  @override
  State<CreateNewTaskCard> createState() => _CreateNewTaskCardState();
}

class _CreateNewTaskCardState extends State<CreateNewTaskCard> {
  final _taskTitleController = TextEditingController();
  final _subTaskController = TextEditingController();

  void _addSubTask() {
    final text = _subTaskController.text.trim();
    if (text.isEmpty) return;

    context.read<CreateTaskCubit>().addSubTask(text);
    _subTaskController.clear();
  }

  @override
  void dispose() {
    _taskTitleController.dispose();
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TaskCardTitle(),
          const SizedBox(height: 16),
          TaskTitleField(controller: _taskTitleController),
          const SizedBox(height: 16),
          SubTaskTextField(
            controller: _subTaskController,
            onAddSubTask: _addSubTask,
          ),
          const SizedBox(height: 16),
          BlocBuilder<CreateTaskCubit, CreateTaskState>(
            buildWhen:
                (previous, current) => previous.subTasks != current.subTasks,
            builder: (context, state) {
              return SubTasksList(
                subTasks: state.subTasks,
                onRemove: (index) {
                  context.read<CreateTaskCubit>().removeSubTask(index);
                },
              );
            },
          ),
          const SizedBox(height: 30),
          const TaskActions(),
        ],
      ),
    );
  }
}
