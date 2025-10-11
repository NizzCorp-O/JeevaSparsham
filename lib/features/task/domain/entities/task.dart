import 'package:cloud_firestore/cloud_firestore.dart';

class TaskEntity {
  final String id;
  final String taskType;
  final String notes;
  final String patientId;
  final String? requestId; // optional link to request
  final String assignedTo; // nurse or volunteer UID
  final String status; // Assigned | Accepted | Completed
  final DateTime date;

  TaskEntity({
    required this.id,
    required this.taskType,
    required this.notes,
    required this.patientId,
    this.requestId,
    required this.assignedTo,
    required this.status,
    required this.date,
  });

  factory TaskEntity.fromMap(String id, Map<String, dynamic> map) {
    return TaskEntity(
      id: id,
      taskType: map['taskType'] ?? '',
      notes: map['notes'] ?? '',
      patientId: map['patientId'] ?? '',
      requestId: map['requestId'],
      assignedTo: map['assignedTo'] ?? '',
      status: map['status'] ?? 'Assigned',
      date: (map['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskType': taskType,
      'notes': notes,
      'patientId': patientId,
      'requestId': requestId,
      'assignedTo': assignedTo,
      'status': status,
      'date': date,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
