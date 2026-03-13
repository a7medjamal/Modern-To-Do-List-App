import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final String category;
  final bool isCompleted;
  final List<String> subTasks;
  final DateTime timestamp;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.isCompleted,
    required this.subTasks,
    required this.timestamp,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    bool? isCompleted,
    List<String>? subTasks,
    DateTime? timestamp,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      subTasks: subTasks ?? this.subTasks,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    isCompleted,
    subTasks,
    timestamp,
  ];
}
