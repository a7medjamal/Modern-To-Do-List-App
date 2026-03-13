import 'package:cat_to_do_list/features/tasks/presentation/widgets/task_action_buttons.dart';
import 'package:cat_to_do_list/features/tasks/presentation/widgets/task_category_dropdown.dart';
import 'package:cat_to_do_list/features/tasks/presentation/widgets/task_description_field.dart';
import 'package:cat_to_do_list/features/tasks/presentation/widgets/task_title_field.dart';
import 'package:flutter/material.dart';

class TaskDetailsForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String selectedCategory;
  final List<String> categories;
  final bool isExistingTask;
  final ValueChanged<String> onCategoryChanged;
  final VoidCallback onSave;
  final VoidCallback onDelete;

  const TaskDetailsForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.selectedCategory,
    required this.categories,
    required this.isExistingTask,
    required this.onCategoryChanged,
    required this.onSave,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TaskTitleField(controller: titleController),
              const SizedBox(height: 16),
              TaskDescriptionField(controller: descriptionController),
              const SizedBox(height: 16),
              TaskCategoryDropdown(
                selectedCategory: selectedCategory,
                categories: categories,
                onChanged: onCategoryChanged,
              ),
              const SizedBox(height: 30),
              TaskActionButtons(
                isExistingTask: isExistingTask,
                onSave: onSave,
                onDelete: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
