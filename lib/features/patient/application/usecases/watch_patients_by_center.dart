import '../../domain/entities/patient.dart';
import '../../domain/repositories/patient_repository.dart';

class WatchPatientsByCenter {
  final PatientRepository repository;
  WatchPatientsByCenter(this.repository);

  Stream<List<Patient>> call(String centerId) {
    return repository.watchByCenter(centerId);
  }
}
