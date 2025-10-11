import '../../domain/entities/patient.dart';
import '../../domain/repositories/patient_repository.dart';

class AddPatient {
  final PatientRepository repository;
  AddPatient(this.repository);

  Future<void> call(Patient patient) async {
    await repository.add(patient);
  }
}
