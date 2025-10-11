import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hello_pratice/features/patient/domain/entities/patient.dart';
import 'package:hello_pratice/features/patient/domain/repositories/patient_repository.dart';


class PatientRepositoryImpl implements PatientRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference get _col => db.collection('patients');

  @override
  Future<void> add(Patient patient) async {
    await _col.doc(patient.id).set(patient.toMap());
  }

  @override
  Future<Patient?> getById(String id) async {
    final doc = await _col.doc(id).get();
    if (!doc.exists) return null;
    return Patient.fromMap(doc.id, doc.data() as Map<String, dynamic>);
  }

  @override
  Stream<List<Patient>> watchByCenter(String centerId) {
    return _col
        .where('centerId', isEqualTo: centerId)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) =>
                Patient.fromMap(d.id, d.data() as Map<String, dynamic>))
            .toList());
  }
}
