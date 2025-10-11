import '../entities/patient.dart';

abstract class PatientRepository {
  Future<void> add(Patient patient);
  Future<Patient?> getById(String id);
  Stream<List<Patient>> watchByCenter(String centerId);
}
