import 'package:cat_to_do_list/features/tasks/domain/entities/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final bool isCompleted;
  final DateTime timestamp;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.isCompleted,
    required this.timestamp,
  });

  Task toEntity() {
    return Task(
      id: id,
      title: title,
      description: description,
      category: category,
      isCompleted: isCompleted,
      timestamp: timestamp,
    );
  }

  factory TaskModel.fromMap(Map<String, dynamic> map, {String? documentId}) {
    final String id = documentId ?? map['id'] ?? '';

    if (map['title'] == null) {
      throw FormatException('Task title is required');
    }

    return TaskModel(
      id: id,
      title: map['title'] as String,
      description: map['description'] as String? ?? '',
      category: map['category'] as String? ?? 'Uncategorized',
      isCompleted: map['isCompleted'] as bool? ?? false,
      timestamp: _parseTimestamp(map['timestamp']),
    );
  }

  static DateTime _parseTimestamp(dynamic value) {
    if (value == null) return DateTime.now();

    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) {
      final parsed = DateTime.tryParse(value);
      if (parsed != null) return parsed;
    }

    return DateTime.now();
  }

  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      category: task.category,
      isCompleted: task.isCompleted,
      timestamp: task.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'isCompleted': isCompleted,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
