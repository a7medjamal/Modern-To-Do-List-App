import 'package:cat_to_do_list/features/tasks/domain/entities/task.dart';
import 'package:cat_to_do_list/features/tasks/presentation/screens/cubit/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class TaskDetailsScreen extends StatefulWidget {
  final String? taskId;

  const TaskDetailsScreen({super.key, this.taskId});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _selectedCategory = 'Personal';
  final List<String> _categories = ['Personal', 'Work', 'Shopping', 'Other'];

  bool _isLoading = false;
  bool _isExistingTask = false;
  Task? _initialTaskData;
  final Uuid _uuid = const Uuid();

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
      if (task != null && mounted) {
        setState(() {
          _initialTaskData = task;
          _titleController.text = task.title;
          _descriptionController.text = task.description;
          _selectedCategory =
              _categories.contains(task.category) ? task.category : 'Other';
        });
      } else if (mounted) {
        _showErrorSnackbar('Task not found.');
        GoRouter.of(context).pop();
      }
    } catch (e) {
      if (mounted) _showErrorSnackbar('Error loading task: ${e.toString()}');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _saveTask() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      final task = Task(
        id: widget.taskId ?? _uuid.v4(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategory,
        isCompleted:
            _isExistingTask ? (_initialTaskData?.isCompleted ?? false) : false,
        timestamp:
            _isExistingTask
                ? (_initialTaskData?.timestamp ?? DateTime.now())
                : DateTime.now(),
      );
      try {
        final taskCubit = context.read<TaskCubit>();
        if (_isExistingTask) {
          await taskCubit.updateTask(task);
        } else {
          await taskCubit.addTask(task);
        }
        if (mounted) GoRouter.of(context).pop();
      } catch (e) {
        if (mounted) _showErrorSnackbar('Error saving task: ${e.toString()}');
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _deleteTask() async {
    if (widget.taskId != null) {
      final confirm = await showDialog<bool>(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Delete Task?'),
              content: const Text('Are you sure you want to delete this task?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
      );

      if (confirm == true) {
        setState(() => _isLoading = true);
        try {
          await context.read<TaskCubit>().deleteTask(widget.taskId!);
          if (mounted) Navigator.pop(context);
        } catch (e) {
          if (mounted)
            _showErrorSnackbar('Error deleting task: ${e.toString()}');
        } finally {
          if (mounted) setState(() => _isLoading = false);
        }
      }
    }
  }

  void _showErrorSnackbar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1535),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          _isExistingTask ? 'Edit Task' : 'New Task',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF242443),
        elevation: 0,
      ),
      body: SafeArea(
        child:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _titleController,
                            style: const TextStyle(color: Colors.white),
                            decoration: _inputDecoration('Task Title'),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a title';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _descriptionController,
                            maxLines: 4,
                            style: const TextStyle(color: Colors.white),
                            decoration: _inputDecoration(
                              'Description (Optional)',
                            ),
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _selectedCategory,
                            dropdownColor: const Color(0xFF29214C),
                            items:
                                _categories
                                    .map(
                                      (cat) => DropdownMenuItem(
                                        value: cat,
                                        child: Text(
                                          cat,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _selectedCategory = value);
                              }
                            },
                            decoration: _inputDecoration('Category'),
                            style: const TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.white70,
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: _saveTask,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Text(
                              _isExistingTask ? 'Update Task' : 'Save Task',
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (_isExistingTask)
                            ElevatedButton(
                              onPressed: _deleteTask,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                              ),
                              child: const Text('Delete Task'),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
      ),
    );
  }

  // Helper for input decoration
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white54),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurpleAccent),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
