import 'package:cat_to_do_list/features/home/presentation/widgets/empty_tasks_view.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/home_task_sections.dart';
import 'package:cat_to_do_list/features/home/presentation/widgets/task_error_view.dart';
import 'package:cat_to_do_list/features/tasks/presentation/cubit/task_cubit.dart';
import 'package:cat_to_do_list/features/tasks/presentation/cubit/task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TaskInitial) {
          return const SizedBox.shrink();
        }
        if (state is TaskError) {
          return TaskErrorView(message: state.message);
        }
        if (state is TaskLoaded) {
          if (state.tasks.isEmpty) {
            return const EmptyTasksView();
          }
          return HomeTaskSections(tasks: state.tasks);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
