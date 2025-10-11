import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/visit.dart';
import '../usecases/add_visit.dart';
import '../usecases/watch_visits.dart';
import 'visit_event.dart';
import 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  final AddVisit addVisit;
  final WatchVisits watchVisits;

  VisitBloc({
    required this.addVisit,
    required this.watchVisits,
  }) : super(VisitInitial()) {
    on<LoadVisits>((event, emit) async {
      emit(VisitLoading());
      await emit.forEach<List<Visit>>(
        watchVisits(event.patientId),
        onData: (visits) => VisitListLoaded(visits),
        onError: (_, __) => VisitError("Failed to load visits"),
      );
    });

    on<AddVisitEvent>((event, emit) async {
      emit(VisitLoading());
      try {
        await addVisit(event.patientId, event.visit);
        emit(VisitSuccess());
      } catch (e) {
        emit(VisitError(e.toString()));
      }
    });
  }
}
