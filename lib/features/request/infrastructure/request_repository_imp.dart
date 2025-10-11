import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_pratice/features/request/domain/entities/request.dart';
import 'package:hello_pratice/features/request/domain/repositories/request_repository.dart';


class RequestRepositoryImpl implements RequestRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference get _col => db.collection('requests');

  @override
  Future<void> create(RequestEntity request) async {
    await _col.add(request.toMap());
  }

  @override
  Stream<List<RequestEntity>> watchByPatient(String patientId) {
    return _col
        .where('patientId', isEqualTo: patientId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) =>
                RequestEntity.fromMap(d.id, d.data() as Map<String, dynamic>))
            .toList());
  }

  @override
  Stream<List<RequestEntity>> watchAllPending(String centerId) {
    return _col
        .where('centerId', isEqualTo: centerId)
        .where('status', isEqualTo: 'Pending')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) =>
                RequestEntity.fromMap(d.id, d.data() as Map<String, dynamic>))
            .toList());
  }

  @override
  Future<void> assign(String requestId, String assigneeUid) async {
    await _col.doc(requestId).update({
      'assignedTo': assigneeUid,
      'status': 'Assigned',
      'assignedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> updateStatus(String requestId, String status) async {
    await _col.doc(requestId).update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
