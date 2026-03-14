import 'package:cat_to_do_list/features/tasks/domain/entities/task.dart';
import 'package:cat_to_do_list/features/tasks/presentation/cubit/task_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'task_details_state.dart';

class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  TaskDetailsCubit({required this.taskCubit, required this.taskId})
    : _uuid = const Uuid(),
      super(
        TaskDetailsState.initial(
          isExistingTask: taskId != null && taskId.isNotEmpty,
        ),
      );

  final TaskCubit taskCubit;
  final String? taskId;
  final Uuid _uuid;

  Future<void> initialize() async {
    if (!state.isExistingTask || taskId == null) return;

    emit(state.copyWith(isLoading: true, clearErrorMessage: true));

    try {
      final task = await taskCubit.getTaskById(taskId!);

      if (task == null) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Task not found.',
            shouldPop: true,
          ),
        );
        return;
      }

      final category =
          state.categories.contains(task.category) ? task.category : 'Other';

      emit(
        state.copyWith(
          isLoading: false,
          initialTaskData: task,
          selectedCategory: category,
          subTasks: List<String>.from(task.subTasks),
          clearErrorMessage: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Error loading task: $e',
        ),
      );
    }
  }

  void changeCategory(String value) {
    emit(state.copyWith(selectedCategory: value));
  }

  void addSubTask(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    final updated = List<String>.from(state.subTasks)..add(trimmed);
    emit(state.copyWith(subTasks: updated));
  }

  void removeSubTask(int index) {
    if (index < 0 || index >= state.subTasks.length) return;

    final updated = List<String>.from(state.subTasks)..removeAt(index);
    emit(state.copyWith(subTasks: updated));
  }

  Future<void> saveTask({
    required String title,
    required String description,
  }) async {
    emit(state.copyWith(isLoading: true, clearErrorMessage: true));

    final task = Task(
      id: taskId ?? _uuid.v4(),
      title: title.trim(),
      description: description.trim(),
      category: state.selectedCategory,
      isCompleted: state.initialTaskData?.isCompleted ?? false,
      timestamp: state.initialTaskData?.timestamp ?? DateTime.now(),
      subTasks: List<String>.from(state.subTasks),
    );

    try {
      if (state.isExistingTask) {
        await taskCubit.updateTask(task);
      } else {
        await taskCubit.addTask(task);
      }

      emit(state.copyWith(isLoading: false, shouldPop: true));
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, errorMessage: 'Error saving task: $e'),
      );
    }
  }

  Future<void> deleteTask() async {
    if (taskId == null) return;

    emit(state.copyWith(isLoading: true, clearErrorMessage: true));

    try {
      await taskCubit.deleteTask(taskId!);

      emit(state.copyWith(isLoading: false, shouldPop: true));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Error deleting task: $e',
        ),
      );
    }
  }

  void consumeSideEffects() {
    emit(state.copyWith(shouldPop: false, clearErrorMessage: true));
  }
}
