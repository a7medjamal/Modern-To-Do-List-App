import 'package:cat_to_do_list/features/tasks/domain/entities/task.dart';
import 'package:equatable/equatable.dart';

class TaskDetailsState extends Equatable {
  final bool isLoading;
  final bool isExistingTask;
  final Task? initialTaskData;
  final String selectedCategory;
  final List<String> categories;
  final List<String> subTasks;
  final String? errorMessage;
  final bool shouldPop;

  const TaskDetailsState({
    required this.isLoading,
    required this.isExistingTask,
    required this.initialTaskData,
    required this.selectedCategory,
    required this.categories,
    required this.subTasks,
    required this.errorMessage,
    required this.shouldPop,
  });

  factory TaskDetailsState.initial({required bool isExistingTask}) {
    return TaskDetailsState(
      isLoading: false,
      isExistingTask: isExistingTask,
      initialTaskData: null,
      selectedCategory: 'Personal',
      categories: const ['Personal', 'Work', 'Shopping', 'Other'],
      subTasks: const [],
      errorMessage: null,
      shouldPop: false,
    );
  }

  TaskDetailsState copyWith({
    bool? isLoading,
    bool? isExistingTask,
    Task? initialTaskData,
    String? selectedCategory,
    List<String>? categories,
    List<String>? subTasks,
    String? errorMessage,
    bool? shouldPop,
    bool clearErrorMessage = false,
  }) {
    return TaskDetailsState(
      isLoading: isLoading ?? this.isLoading,
      isExistingTask: isExistingTask ?? this.isExistingTask,
      initialTaskData: initialTaskData ?? this.initialTaskData,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categories: categories ?? this.categories,
      subTasks: subTasks ?? this.subTasks,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      shouldPop: shouldPop ?? this.shouldPop,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isExistingTask,
    initialTaskData,
    selectedCategory,
    categories,
    subTasks,
    errorMessage,
    shouldPop,
  ];
}
