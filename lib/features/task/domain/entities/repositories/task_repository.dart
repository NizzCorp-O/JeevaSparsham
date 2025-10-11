import 'package:hello_pratice/features/task/domain/entities/task.dart';



abstract class TaskRepository {
  Future<void> create(TaskEntity task);
  Stream<List<TaskEntity>> watchAssignedTo(String uid);
  Stream<List<TaskEntity>> watchCompletedBy(String uid);
  Future<void> updateStatus(String taskId, String status);
}
