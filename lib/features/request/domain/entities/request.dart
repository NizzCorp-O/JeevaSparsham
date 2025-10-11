import 'package:cloud_firestore/cloud_firestore.dart';

class RequestEntity {
  final String id;
  final String patientId;
  final String createdBy;
  final String supportType; // Medical | Emotional | Daily Help | Medicine
  final String notes;
  final DateTime date;
  final String status; // Pending | Assigned | Accepted | Completed
  final String? assignedTo;
  final String centerId;

  RequestEntity({
    required this.id,
    required this.patientId,
    required this.createdBy,
    required this.supportType,
    required this.notes,
    required this.date,
    required this.status,
    this.assignedTo,
    required this.centerId,
  });

  factory RequestEntity.fromMap(String id, Map<String, dynamic> map) {
    return RequestEntity(
      id: id,
      patientId: map['patientId'] ?? '',
      createdBy: map['createdBy'] ?? '',
      supportType: map['supportType'] ?? '',
      notes: map['notes'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      status: map['status'] ?? 'Pending',
      assignedTo: map['assignedTo'],
      centerId: map['centerId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'createdBy': createdBy,
      'supportType': supportType,
      'notes': notes,
      'date': date,
      'status': status,
      'assignedTo': assignedTo,
      'centerId': centerId,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
