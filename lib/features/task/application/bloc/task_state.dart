import '../../domain/entities/task.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskListLoaded extends TaskState {
  final List<TaskEntity> items;
  TaskListLoaded(this.items);
}

class TaskSuccess extends TaskState {}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}
