import 'package:cat_to_do_list/features/tasks/presentation/cubit/task_cubit.dart';
import 'package:cat_to_do_list/features/tasks/presentation/cubit/task_details/task_details_cubit.dart';
import 'package:cat_to_do_list/features/tasks/presentation/cubit/task_details/task_details_state.dart';
import 'package:cat_to_do_list/features/tasks/presentation/widgets/task_details/task_details_app_bar.dart';
import 'package:cat_to_do_list/features/tasks/presentation/widgets/task_details/task_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TaskDetailsScreen extends StatelessWidget {
  final String? taskId;

  const TaskDetailsScreen({super.key, this.taskId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskDetailsCubit>(
      create:
          (_) => TaskDetailsCubit(
            taskCubit: context.read<TaskCubit>(),
            taskId: taskId,
          )..initialize(),
      child: const _TaskDetailsView(),
    );
  }
}

class _TaskDetailsView extends StatefulWidget {
  const _TaskDetailsView();

  @override
  State<_TaskDetailsView> createState() => _TaskDetailsViewState();
}

class _TaskDetailsViewState extends State<_TaskDetailsView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _subTaskController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _didFillInitialControllers = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _subTaskController.dispose();
    super.dispose();
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final cubit = context.read<TaskDetailsCubit>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Task?'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await cubit.deleteTask();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskDetailsCubit, TaskDetailsState>(
      listener: (context, state) {
        if (!_didFillInitialControllers && state.initialTaskData != null) {
          _titleController.text = state.initialTaskData!.title;
          _descriptionController.text = state.initialTaskData!.description;
          _didFillInitialControllers = true;
        }

        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.redAccent,
            ),
          );
          context.read<TaskDetailsCubit>().consumeSideEffects();
        }

        if (state.shouldPop) {
          context.read<TaskDetailsCubit>().consumeSideEffects();
          context.pop();
        }
      },
      child: BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
        builder: (context, state) {
          final cubit = context.read<TaskDetailsCubit>();

          return Scaffold(
            backgroundColor: const Color(0xFF1B1535),
            appBar: TaskDetailsAppBar(isExistingTask: state.isExistingTask),
            body: TaskDetailsBody(
              isLoading: state.isLoading,
              formKey: _formKey,
              titleController: _titleController,
              descriptionController: _descriptionController,
              subTaskController: _subTaskController,
              selectedCategory: state.selectedCategory,
              categories: state.categories,
              subTasks: state.subTasks,
              isExistingTask: state.isExistingTask,
              onCategoryChanged: cubit.changeCategory,
              onAddSubTask: () {
                final text = _subTaskController.text.trim();
                if (text.isEmpty) return;

                cubit.addSubTask(text);
                _subTaskController.clear();
              },
              onRemoveSubTask: cubit.removeSubTask,
              onSave: () {
                if (!(_formKey.currentState?.validate() ?? false)) return;

                cubit.saveTask(
                  title: _titleController.text,
                  description: _descriptionController.text,
                );
              },
              onDelete: () => _confirmDelete(context),
            ),
          );
        },
      ),
    );
  }
}
