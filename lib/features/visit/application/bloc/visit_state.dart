import '../../domain/entities/visit.dart';

abstract class VisitState {}

class VisitInitial extends VisitState {}

class VisitLoading extends VisitState {}

class VisitListLoaded extends VisitState {
  final List<Visit> visits;
  VisitListLoaded(this.visits);
}

class VisitSuccess extends VisitState {}

class VisitError extends VisitState {
  final String message;
  VisitError(this.message);
}
