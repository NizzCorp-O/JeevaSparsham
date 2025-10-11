import '../../domain/entities/visit.dart';
import '../../domain/repositories/visit_repository.dart';

class AddVisit {
  final VisitRepository repo;
  AddVisit(this.repo);

  Future<void> call(String patientId, Visit visit) =>
      repo.addVisit(patientId, visit);
}
