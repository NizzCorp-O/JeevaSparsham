import 'package:hello_pratice/features/task/domain/entities/repositories/task_repository.dart';

import '../../domain/entities/task.dart';


class CreateTask {
  final TaskRepository repo;
  CreateTask(this.repo);

  Future<void> call(TaskEntity task) => repo.create(task);
}
