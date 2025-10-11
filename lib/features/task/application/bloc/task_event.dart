import 'package:hello_pratice/features/patient/domain/entities/patient.dart';



abstract class PatientEvent {}

class LoadPatient extends PatientEvent {
  final String id;
  LoadPatient(this.id);
}

class WatchPatients extends PatientEvent {
  final String centerId;
  WatchPatients(this.centerId);
}

class PatientsUpdated extends PatientEvent {
  final List<Patient> patients;
  PatientsUpdated(this.patients);
}

class AddPatientEvent extends PatientEvent {
  final Patient patient;
  AddPatientEvent(this.patient);
}
