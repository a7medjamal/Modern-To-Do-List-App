import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cat_to_do_list/features/tasks/data/models/task_model.dart';
import 'package:cat_to_do_list/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:cat_to_do_list/core/utils/auth_helper.dart';

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final FirebaseFirestore firestore;

  TaskRemoteDataSourceImpl({required this.firestore});

  String _taskPath(String uid) => 'users/$uid/tasks';

  @override
  Future<void> addTask(TaskModel task) async {
    final uid = AuthHelper.getCurrentUserId();
    await firestore
        .collection(_taskPath(uid))
        .doc(task.id)
        .set(task.toMap());
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    final uid = AuthHelper.getCurrentUserId();
    await firestore
        .collection(_taskPath(uid))
        .doc(task.id)
        .update(task.toMap());
  }

  @override
  Future<void> deleteTask(String taskId) async {
    final uid = AuthHelper.getCurrentUserId();
    await firestore
        .collection(_taskPath(uid))
        .doc(taskId)
        .delete();
  }

  @override
  Stream<List<TaskModel>> getTasks() {
    final uid = AuthHelper.getCurrentUserId();
    return firestore
        .collection(_taskPath(uid))
        .orderBy('title')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TaskModel.fromMap(doc.data()))
            .toList());
  }

  Future<TaskModel?> getTask(String taskId) async {
    final uid = AuthHelper.getCurrentUserId();
    final docSnapshot = await firestore
        .collection(_taskPath(uid))
        .doc(taskId)
        .get();

    if (docSnapshot.exists) {
      return TaskModel.fromMap(docSnapshot.data()!);
    } else {
      return null;
    }
  }
}
