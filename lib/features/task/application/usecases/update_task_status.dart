import 'package:hello_pratice/features/task/domain/entities/repositories/task_repository.dart';



class UpdateTaskStatus {
  final TaskRepository repo;
  UpdateTaskStatus(this.repo);

  Future<void> call(String taskId, String status) =>
      repo.updateStatus(taskId, status);
}
