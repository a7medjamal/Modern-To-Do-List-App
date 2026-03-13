import 'package:cat_to_do_list/features/home/presentation/widgets/action_elevated_button.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/action_outlined_button.dart';
import 'package:flutter/material.dart';

class TaskActions extends StatelessWidget {
  const TaskActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ActionOutlinedButton(
          label: 'Category',
          onPressed: () {},
        ),
        const SizedBox(width: 10),
        ActionOutlinedButton(
          label: 'Date & Time',
          onPressed: () {},
        ),
        const SizedBox(width: 10),
        ActionElevatedButton(
          label: 'Set',
          onPressed: () {},
        ),
      ],
    );
  }
}