import 'package:cat_to_do_list/features/tasks/presentation/widgets/task_details_form.dart';
import 'package:flutter/material.dart';

class TaskDetailsBody extends StatelessWidget {
  const TaskDetailsBody({
    super.key,
    required this.isLoading,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.subTaskController,
    required this.selectedCategory,
    required this.categories,
    required this.subTasks,
    required this.isExistingTask,
    required this.onCategoryChanged,
    required this.onAddSubTask,
    required this.onRemoveSubTask,
    required this.onSave,
    required this.onDelete,
  });

  final bool isLoading;
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController subTaskController;
  final String selectedCategory;
  final List<String> categories;
  final List<String> subTasks;
  final bool isExistingTask;
  final ValueChanged<String> onCategoryChanged;
  final VoidCallback onAddSubTask;
  final ValueChanged<int> onRemoveSubTask;
  final VoidCallback onSave;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return TaskDetailsForm(
      formKey: formKey,
      titleController: titleController,
      descriptionController: descriptionController,
      subTaskController: subTaskController,
      selectedCategory: selectedCategory,
      categories: categories,
      subTasks: subTasks,
      isExistingTask: isExistingTask,
      onCategoryChanged: onCategoryChanged,
      onAddSubTask: onAddSubTask,
      onRemoveSubTask: onRemoveSubTask,
      onSave: onSave,
      onDelete: onDelete,
    );
  }
}
