import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/patient.dart';
import '../usecases/add_patient.dart';
import '../usecases/get_patient.dart';
import '../usecases/watch_patients_by_center.dart';
import 'patient_event.dart';
import 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final AddPatient addPatient;
  final GetPatient getPatient;
  final WatchPatientsByCenter watchPatientsByCenter;

  Stream<List<Patient>>? _subscription;

  PatientBloc({
    required this.addPatient,
    required this.getPatient,
    required this.watchPatientsByCenter,
  }) : super(PatientInitial()) {
    // Get a single patient by ID
    on<LoadPatient>((event, emit) async {
      emit(PatientLoading());
      try {
        final patient = await getPatient(event.id);
        if (patient == null) {
          emit(PatientError("Patient not found"));
        } else {
          emit(PatientLoaded(patient));
        }
      } catch (e) {
        emit(PatientError(e.toString()));
      }
    });

    // Watch patients by centerId (real-time updates)
    on<WatchPatients>((event, emit) async {
      emit(PatientLoading());
      _subscription = watchPatientsByCenter(event.centerId);
      _subscription!.listen(
        (patients) => add(PatientsUpdated(patients)),
        onError: (err) => emit(PatientError(err.toString())),
      );
    });

    // Update state when Firestore stream pushes new patients
    on<PatientsUpdated>((event, emit) {
      emit(PatientListLoaded(event.patients));
    });

    // Add new patient
    on<AddPatientEvent>((event, emit) async {
      emit(PatientLoading());
      try {
        await addPatient(event.patient);
        emit(PatientSuccess());
      } catch (e) {
        emit(PatientError(e.toString()));
      }
    });
  }

  @override
  Future<void> close() async {
    _subscription = null;
    return super.close();
  }
}
