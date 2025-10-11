import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_pratice/features/visit/domain/entities/visit.dart';
import 'package:hello_pratice/features/visit/domain/repositories/visit_repository.dart';


class VisitRepositoryImpl implements VisitRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<void> addVisit(String patientId, Visit visit) async {
    await db
        .collection('patients')
        .doc(patientId)
        .collection('visits')
        .add(visit.toMap());
  }

  @override
  Stream<List<Visit>> watchVisits(String patientId) {
    return db
        .collection('patients')
        .doc(patientId)
        .collection('visits')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => Visit.fromMap(
                  d.id,
                  patientId,
                  d.data(),
                ))
            .toList());
  }
}
