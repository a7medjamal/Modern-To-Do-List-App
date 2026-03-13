import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubTaskTextField extends StatelessWidget {
  const SubTaskTextField({
    super.key,
    required this.controller,
    required this.onAddSubTask,
  });

  final TextEditingController controller;
  final VoidCallback onAddSubTask;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Add sub-task',
        hintStyle: const TextStyle(color: Colors.white54),

        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),

        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),

        suffixIcon: IconButton(
          onPressed: onAddSubTask,
          icon: SvgPicture.asset(
            'assets/icons/add_icon.svg',
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),

      onSubmitted: (_) => onAddSubTask(),
    );
  }
}
