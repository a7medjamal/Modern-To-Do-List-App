import 'package:flutter/material.dart';

class SubTaskItem extends StatelessWidget {
  const SubTaskItem({super.key, required this.text, required this.onRemove});

  final String text;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF242443),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(text, style: const TextStyle(color: Colors.white)),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.close, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}
