import 'package:cat_to_do_list/features/tasks/domain/entities/task.dart';

abstract class TaskRepository {
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String taskId);
  Stream<List<Task>> getTasks();
  Future<Task?> getTaskById(String taskId);
}
