import 'package:cat_to_do_list/features/tasks/domain/entities/task.dart';
import 'package:cat_to_do_list/features/tasks/presentation/cubit/task_cubit.dart';
import 'package:cat_to_do_list/features/tasks/presentation/widgets/task_details/task_details_app_bar.dart';
import 'package:cat_to_do_list/features/tasks/presentation/widgets/task_details/task_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class TaskDetailsView extends StatefulWidget {
  final String? taskId;

  const TaskDetailsView({super.key, this.taskId});

  @override
  State<TaskDetailsView> createState() => _TaskDetailsViewState();
}

class _TaskDetailsViewState extends State<TaskDetailsView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _subTaskController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  final List<String> _categories = ['Personal', 'Work', 'Shopping', 'Other'];
  final List<String> _subTasks = [];

  String _selectedCategory = 'Personal';
  bool _isLoading = false;
  late final bool _isExistingTask;
  Task? _initialTaskData;

  @override
  void initState() {
    super.initState();
    _isExistingTask = widget.taskId != null && widget.taskId!.isNotEmpty;

    if (_isExistingTask) {
      _loadTaskData();
    }
  }

  Future<void> _loadTaskData() async {
    setState(() => _isLoading = true);

    try {
      final task = await context.read<TaskCubit>().getTaskById(widget.taskId!);

      if (!mounted) return;

      if (task == null) {
        _showErrorSnackbar('Task not found.');
        context.pop();
        return;
      }

      setState(() {
        _initialTaskData = task;
        _titleController.text = task.title;
        _descriptionController.text = task.description;
        _selectedCategory =
            _categories.contains(task.category) ? task.category : 'Other';

        _subTasks
          ..clear()
          ..addAll(task.subTasks);
      });
    } catch (e) {
      if (mounted) {
        _showErrorSnackbar('Error loading task: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _addSubTask() {
    final text = _subTaskController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _subTasks.add(text);
      _subTaskController.clear();
    });
  }

  void _removeSubTask(int index) {
    if (index < 0 || index >= _subTasks.length) return;

    setState(() {
      _subTasks.removeAt(index);
    });
  }

  Future<void> _saveTask() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    final task = Task(
      id: widget.taskId ?? _uuid.v4(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory,
      isCompleted: _initialTaskData?.isCompleted ?? false,
      timestamp: _initialTaskData?.timestamp ?? DateTime.now(),
      subTasks: List<String>.from(_subTasks),
    );

    try {
      final cubit = context.read<TaskCubit>();

      if (_isExistingTask) {
        await cubit.updateTask(task);
      } else {
        await cubit.addTask(task);
      }

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackbar('Error saving task: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _deleteTask() async {
    if (widget.taskId == null) return;

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

    if (confirm != true) return;

    setState(() => _isLoading = true);

    try {
      await context.read<TaskCubit>().deleteTask(widget.taskId!);

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackbar('Error deleting task: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1535),
      appBar: TaskDetailsAppBar(isExistingTask: _isExistingTask),
      body: TaskDetailsController(
        isLoading: _isLoading,
        formKey: _formKey,
        titleController: _titleController,
        descriptionController: _descriptionController,
        subTaskController: _subTaskController,
        selectedCategory: _selectedCategory,
        categories: _categories,
        subTasks: _subTasks,
        isExistingTask: _isExistingTask,
        onCategoryChanged: (value) {
          setState(() => _selectedCategory = value);
        },
        onAddSubTask: _addSubTask,
        onRemoveSubTask: _removeSubTask,
        onSave: _saveTask,
        onDelete: _deleteTask,
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _subTaskController.dispose();
    super.dispose();
  }
}
