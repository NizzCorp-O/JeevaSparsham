import 'package:hello_pratice/features/task/domain/entities/repositories/task_repository.dart';

import '../../domain/entities/task.dart';


class WatchTasksForUser {
  final TaskRepository repo;
  WatchTasksForUser(this.repo);

  Stream<List<TaskEntity>> call(String uid) => repo.watchAssignedTo(uid);
}
