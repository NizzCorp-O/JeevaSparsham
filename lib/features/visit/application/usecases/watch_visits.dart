import '../../domain/entities/visit.dart';
import '../../domain/repositories/visit_repository.dart';

class WatchVisits {
  final VisitRepository repo;
  WatchVisits(this.repo);

  Stream<List<Visit>> call(String patientId) => repo.watchVisits(patientId);
}
