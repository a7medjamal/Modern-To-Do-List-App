import 'package:cat_to_do_list/features/home/presentation/widgets/subtask_text_field.dart';
import 'package:cat_to_do_list/features/tasks/presentation/widgets/task_action_buttons.dart';
import 'package:cat_to_do_list/features/tasks/presentation/widgets/task_category_dropdown.dart';
import 'package:cat_to_do_list/features/tasks/presentation/widgets/task_description_field.dart';
import 'package:cat_to_do_list/features/tasks/presentation/widgets/task_title_field.dart';
import 'package:flutter/material.dart';

class TaskDetailsForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController subTaskController;
  final String selectedCategory;
  final List<String> categories;
  final List<String> subTasks;
  final bool isExistingTask;
  final ValueChanged<String> onCategoryChanged;
  final VoidCallback onSave;
  final VoidCallback onDelete;
  final VoidCallback onAddSubTask;
  final ValueChanged<int> onRemoveSubTask;

  const TaskDetailsForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.subTaskController,
    required this.selectedCategory,
    required this.categories,
    required this.subTasks,
    required this.isExistingTask,
    required this.onCategoryChanged,
    required this.onSave,
    required this.onDelete,
    required this.onAddSubTask,
    required this.onRemoveSubTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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

            const SizedBox(height: 20),

            const Text(
              'Subtasks',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            SubTaskTextField(
              controller: subTaskController,
              onAddSubTask: onAddSubTask,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child:
                  subTasks.isEmpty
                      ? const SizedBox()
                      : ListView.separated(
                        shrinkWrap: true,
                        itemCount: subTasks.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          return Container(
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
                                    subTasks[index],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => onRemoveSubTask(index),
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),
            TaskActionButtons(
              isExistingTask: isExistingTask,
              onSave: onSave,
              onDelete: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
