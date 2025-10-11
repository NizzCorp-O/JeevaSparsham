import 'package:hello_pratice/features/task/domain/entities/repositories/task_repository.dart';

import '../../domain/entities/task.dart';


class WatchCompletedTasks {
  final TaskRepository repo;
  WatchCompletedTasks(this.repo);

  Stream<List<TaskEntity>> call(String uid) => repo.watchCompletedBy(uid);
}
