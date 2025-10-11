import '../../domain/entities/visit.dart';

abstract class VisitEvent {}

class LoadVisits extends VisitEvent {
  final String patientId;
  LoadVisits(this.patientId);
}

class AddVisitEvent extends VisitEvent {
  final String patientId;
  final Visit visit;
  AddVisitEvent(this.patientId, this.visit);
}

class VisitsUpdated extends VisitEvent {
  final List<Visit> visits;
  VisitsUpdated(this.visits);
}
