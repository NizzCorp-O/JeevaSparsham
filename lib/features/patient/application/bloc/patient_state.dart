import '../../domain/entities/patient.dart';

abstract class PatientState {}

class PatientInitial extends PatientState {}

class PatientLoading extends PatientState {}

class PatientLoaded extends PatientState {
  final Patient patient;
  PatientLoaded(this.patient);
}

class PatientListLoaded extends PatientState {
  final List<Patient> patients;
  PatientListLoaded(this.patients);
}

class PatientSuccess extends PatientState {}

class PatientError extends PatientState {
  final String message;
  PatientError(this.message);
}
