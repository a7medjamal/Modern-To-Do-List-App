import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTaskState {
  final List<String> subTasks;

  const CreateTaskState({this.subTasks = const []});

  CreateTaskState copyWith({List<String>? subTasks}) {
    return CreateTaskState(subTasks: subTasks ?? this.subTasks);
  }
}

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit() : super(const CreateTaskState());

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

  void clearAll() {
    emit(state.copyWith(subTasks: []));
  }
}
