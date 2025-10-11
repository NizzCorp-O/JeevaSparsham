import '../../domain/entities/patient.dart';
import '../../domain/repositories/patient_repository.dart';

class GetPatient {
  final PatientRepository repository;
  GetPatient(this.repository);

  Future<Patient?> call(String id) async {
    return await repository.getById(id);
  }
}
