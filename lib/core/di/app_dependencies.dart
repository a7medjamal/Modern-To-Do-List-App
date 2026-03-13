import 'package:cat_to_do_list/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:cat_to_do_list/features/auth/domain/usecases/login_user.dart';
import 'package:cat_to_do_list/features/auth/domain/usecases/signup_user.dart';
import 'package:cat_to_do_list/features/auth/domain/usecases/user_google_register.dart';
import 'package:cat_to_do_list/features/auth/domain/usecases/user_logout.dart';
import 'package:cat_to_do_list/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:cat_to_do_list/features/tasks/domain/use_cases/add_task.dart';
import 'package:cat_to_do_list/features/tasks/domain/use_cases/delete_task.dart';
import 'package:cat_to_do_list/features/tasks/domain/use_cases/get_task_by_id.dart';
import 'package:cat_to_do_list/features/tasks/domain/use_cases/get_tasks.dart';
import 'package:cat_to_do_list/features/tasks/domain/use_cases/update_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppDependencies {
  late final LoginUser loginUser;
  late final SignUpUser signUpUser;
  late final LogoutUser logoutUser;
  late final SignInWithGoogle signInWithGoogle;

  late final AddTask addTask;
  late final UpdateTask updateTask;
  late final DeleteTask deleteTask;
  late final GetTaskById getTaskById;
  late final GetTasks getTasks;

  AppDependencies() {
    final authRepository = AuthRepositoryImpl();
    final firestore = FirebaseFirestore.instance;
    final taskRepository = TaskRepositoryImpl(firestore: firestore);

    loginUser = LoginUser(authRepository);
    signUpUser = SignUpUser(authRepository);
    logoutUser = LogoutUser(authRepository);
    signInWithGoogle = SignInWithGoogle(authRepository);

    addTask = AddTask(taskRepository);
    updateTask = UpdateTask(taskRepository);
    deleteTask = DeleteTask(taskRepository);
    getTaskById = GetTaskById(taskRepository);
    getTasks = GetTasks(taskRepository);
  }
}
