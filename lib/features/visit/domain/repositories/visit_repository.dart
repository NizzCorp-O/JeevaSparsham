import '../entities/visit.dart';

abstract class VisitRepository {
  Future<void> addVisit(String patientId, Visit visit);
  Stream<List<Visit>> watchVisits(String patientId);
}
