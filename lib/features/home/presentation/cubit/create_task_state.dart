import 'package:equatable/equatable.dart';

class CreateTaskState extends Equatable {
  final List<String> subTasks;

  const CreateTaskState({this.subTasks = const []});

  CreateTaskState copyWith({List<String>? subTasks}) {
    return CreateTaskState(subTasks: subTasks ?? this.subTasks);
  }

  @override
  List<Object?> get props => [subTasks];
}
