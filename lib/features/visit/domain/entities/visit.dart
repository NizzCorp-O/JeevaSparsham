import 'package:cloud_firestore/cloud_firestore.dart';

class Visit {
  final String id;
  final String patientId;
  final DateTime date;
  final String nurseId;
  final String? doctorId;
  final String condition;

  final Map<String, dynamic> vitals;
  final List<Map<String, dynamic>> medicines;
  final Map<String, dynamic>? basicNeeds;
  final Map<String, dynamic>? lifestyle;
  final String? financialStatus;
  final Map<String, dynamic>? environment;
  final Map<String, dynamic>? activityCondition;
  final Map<String, dynamic>? examination;
  final String? investigationNotes;
  final Map<String, dynamic>? doctor;

  Visit({
    required this.id,
    required this.patientId,
    required this.date,
    required this.nurseId,
    this.doctorId,
    required this.condition,
    required this.vitals,
    required this.medicines,
    this.basicNeeds,
    this.lifestyle,
    this.financialStatus,
    this.environment,
    this.activityCondition,
    this.examination,
    this.investigationNotes,
    this.doctor,
  });

  factory Visit.fromMap(String id, String patientId, Map<String, dynamic> map) {
    return Visit(
      id: id,
      patientId: patientId,
      date: (map['date'] as Timestamp).toDate(),
      nurseId: map['nurseId'] ?? '',
      doctorId: map['doctorId'],
      condition: map['condition'] ?? '',
      vitals: Map<String, dynamic>.from(map['vitals'] ?? {}),
      medicines: List<Map<String, dynamic>>.from(map['medicines'] ?? []),
      basicNeeds: map['basicNeeds'] != null
          ? Map<String, dynamic>.from(map['basicNeeds'])
          : null,
      lifestyle: map['lifestyle'] != null
          ? Map<String, dynamic>.from(map['lifestyle'])
          : null,
      financialStatus: map['financialStatus'],
      environment: map['environment'] != null
          ? Map<String, dynamic>.from(map['environment'])
          : null,
      activityCondition: map['activityCondition'] != null
          ? Map<String, dynamic>.from(map['activityCondition'])
          : null,
      examination: map['examination'] != null
          ? Map<String, dynamic>.from(map['examination'])
          : null,
      investigationNotes: map['investigationNotes'],
      doctor: map['doctor'] != null
          ? Map<String, dynamic>.from(map['doctor'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'nurseId': nurseId,
      'doctorId': doctorId,
      'condition': condition,
      'vitals': vitals,
      'medicines': medicines,
      'basicNeeds': basicNeeds,
      'lifestyle': lifestyle,
      'financialStatus': financialStatus,
      'environment': environment,
      'activityCondition': activityCondition,
      'examination': examination,
      'investigationNotes': investigationNotes,
      'doctor': doctor,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
