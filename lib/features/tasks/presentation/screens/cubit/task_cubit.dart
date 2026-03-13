// lib/features/tasks/presentation/screens/cubit/task_cubit.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cat_to_do_list/core/errors/task_exception.dart';
import 'package:cat_to_do_list/features/tasks/domain/entities/task.dart';
import 'package:cat_to_do_list/features/tasks/domain/use_cases/add_task.dart';
import 'package:cat_to_do_list/features/tasks/domain/use_cases/delete_task.dart';
import 'package:cat_to_do_list/features/tasks/domain/use_cases/get_task_by_id.dart';
import 'package:cat_to_do_list/features/tasks/domain/use_cases/get_tasks.dart';
import 'package:cat_to_do_list/features/tasks/domain/use_cases/update_task.dart';
import 'package:cat_to_do_list/features/tasks/presentation/screens/cubit/task_state.dart';
import 'package:flutter/foundation.dart';

class TaskCubit extends Cubit<TaskState> {
  final AddTask _addTask;
  final UpdateTask _updateTask;
  final DeleteTask _deleteTask;
  final GetTaskById _getTaskById;
  final GetTasks _getTasks;

  StreamSubscription? _tasksSubscription;

  TaskCubit({
    required AddTask addTask,
    required UpdateTask updateTask,
    required DeleteTask deleteTask,
    required GetTaskById getTaskById,
    required GetTasks getTasks,
  }) : _addTask = addTask,
       _updateTask = updateTask,
       _deleteTask = deleteTask,
       _getTaskById = getTaskById,
       _getTasks = getTasks,
       super(TaskInitial());

  Future<void> loadTasks() async {
    if (state is TaskLoading) return;

    emit(TaskLoading());
    await _tasksSubscription?.cancel();

    try {
      _tasksSubscription = _getTasks.execute().listen(
        (tasks) {
          emit(TaskLoaded(tasks));
        },
        onError: (error) {
          final errorMessage =
              error is TaskRepositoryException
                  ? error.message
                  : 'Failed to load tasks: ${error.toString()}';
          emit(TaskError(errorMessage));
        },
      );
    } catch (e) {
      final errorMessage =
          e is TaskRepositoryException
              ? e.message
              : 'Failed to initiate task loading: ${e.toString()}';
      emit(TaskError(errorMessage));
    }
  }

  Future<void> addTask(Task task) async {
    final previousState = state;
    try {
      if (task.title.trim().isEmpty) {
        throw TaskRepositoryException('Task title cannot be empty');
      }
      await _addTask.execute(task);
    } catch (e) {
      final errorMessage =
          e is TaskRepositoryException
              ? e.message
              : 'Failed to add task: ${e.toString()}';
      emit(TaskError(errorMessage));
      if (previousState is TaskLoaded) {
        emit(previousState);
      }
    }
  }

  Future<void> updateTask(Task task) async {
    final previousState = state;
    try {
      if (task.id.isEmpty) {
        throw TaskRepositoryException('Cannot update task without an ID');
      }
      if (task.title.trim().isEmpty) {
        throw TaskRepositoryException('Task title cannot be empty');
      }
      await _updateTask.execute(task);
    } catch (e) {
      final errorMessage =
          e is TaskRepositoryException
              ? e.message
              : 'Failed to update task: ${e.toString()}';
      emit(TaskError(errorMessage));
      if (previousState is TaskLoaded) {
        emit(previousState);
      }
    }
  }

  Future<void> deleteTask(String taskId) async {
    final previousState = state;
    try {
      if (taskId.isEmpty) {
        throw TaskRepositoryException('Cannot delete task without an ID');
      }
      await _deleteTask.execute(taskId);
    } catch (e) {
      final errorMessage =
          e is TaskRepositoryException
              ? e.message
              : 'Failed to delete task: ${e.toString()}';
      emit(TaskError(errorMessage));
      if (previousState is TaskLoaded) {
        emit(previousState);
      }
    }
  }

  Future<Task?> getTaskById(String taskId) async {
    try {
      return await _getTaskById.execute(taskId);
    } catch (e) {
      // Log error but don't change global task list state
      debugPrint('Error fetching task by ID: $e');
      return null;
    }
  }

  @override
  Future<void> close() {
    _tasksSubscription?.cancel();
    return super.close();
  }
}
