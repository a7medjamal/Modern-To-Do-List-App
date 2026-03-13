import 'package:cat_to_do_list/features/tasks/presentation/widgets/task_input_decoration.dart';
import 'package:flutter/material.dart';

class TaskCategoryDropdown extends StatelessWidget {
  final String selectedCategory;
  final List<String> categories;
  final ValueChanged<String> onChanged;

  const TaskCategoryDropdown({
    super.key,
    required this.selectedCategory,
    required this.categories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      dropdownColor: const Color(0xFF29214C),
      decoration: taskInputDecoration('Category'),
      style: const TextStyle(color: Colors.white),
      iconEnabledColor: Colors.white70,
      items:
          categories
              .map(
                (category) => DropdownMenuItem<String>(
                  value: category,
                  child: Text(
                    category,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
              .toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}
