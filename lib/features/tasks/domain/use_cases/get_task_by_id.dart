// lib/features/tasks/domain/use_cases/get_task_by_id.dart
import 'package:cat_to_do_list/features/tasks/domain/repositories/task_repository.dart';
import 'package:cat_to_do_list/features/tasks/domain/entities/task.dart';

class GetTaskById {
  final TaskRepository repository;

  GetTaskById(this.repository);

  Future<Task?> execute(String taskId) {
    return repository.getTaskById(taskId);
  }
}
