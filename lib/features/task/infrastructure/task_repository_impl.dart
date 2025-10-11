import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_pratice/features/task/domain/entities/repositories/task_repository.dart';
import 'package:hello_pratice/features/task/domain/entities/task.dart';


class TaskRepositoryImpl implements TaskRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference get _col => db.collection('tasks');

  @override
  Future<void> create(TaskEntity task) async {
    await _col.add(task.toMap());
  }

  @override
  Stream<List<TaskEntity>> watchAssignedTo(String uid) {
    return _col
        .where('assignedTo', isEqualTo: uid)
        .where('status', isNotEqualTo: 'Completed')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) =>
                TaskEntity.fromMap(d.id, d.data() as Map<String, dynamic>))
            .toList());
  }

  @override
  Stream<List<TaskEntity>> watchCompletedBy(String uid) {
    return _col
        .where('assignedTo', isEqualTo: uid)
        .where('status', isEqualTo: 'Completed')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) =>
                TaskEntity.fromMap(d.id, d.data() as Map<String, dynamic>))
            .toList());
  }

  @override
  Future<void> updateStatus(String taskId, String status) async {
    await _col.doc(taskId).update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
