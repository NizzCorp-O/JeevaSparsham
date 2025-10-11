import '../../domain/entities/request.dart';
import '../../domain/repositories/request_repository.dart';

class WatchPatientRequests {
  final RequestRepository repo;
  WatchPatientRequests(this.repo);

  Stream<List<RequestEntity>> call(String patientId) =>
      repo.watchByPatient(patientId);
}
