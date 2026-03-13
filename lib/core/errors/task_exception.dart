/// Exception thrown by the task repository layer.
class TaskRepositoryException implements Exception {
  final String message;
  final dynamic originalException;

  const TaskRepositoryException(this.message, [this.originalException]);

  @override
  String toString() {
    if (originalException != null) {
      return 'TaskRepositoryException: $message (Caused by: $originalException)';
    }
    return 'TaskRepositoryException: $message';
  }
}
