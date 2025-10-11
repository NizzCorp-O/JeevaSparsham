import 'package:cloud_firestore/cloud_firestore.dart';

class HouseholdMember {
  final int no;
  final String name;
  final int age;
  final String relationship;
  final String education;
  final int income;
  final String maritalStatus;

  HouseholdMember({
    required this.no,
    required this.name,
    required this.age,
    required this.relationship,
    required this.education,
    required this.income,
    required this.maritalStatus,
  });

  factory HouseholdMember.fromMap(Map<String, dynamic> map) {
    return HouseholdMember(
      no: map['no'] ?? 0,
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      relationship: map['relationship'] ?? '',
      education: map['education'] ?? '',
      income: map['income'] ?? 0,
      maritalStatus: map['maritalStatus'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'name': name,
      'age': age,
      'relationship': relationship,
      'education': education,
      'income': income,
      'maritalStatus': maritalStatus,
    };
  }
}

class Neighbour {
  final String name;
  final int age;
  final String phone;

  Neighbour({
    required this.name,
    required this.age,
    required this.phone,
  });

  factory Neighbour.fromMap(Map<String, dynamic> map) {
    return Neighbour(
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      phone: map['phone'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'phone': phone,
    };
  }
}

class Patient {
  final String id;
  final String caseNo;
  final String name;
  final int age;
  final String gender;
  final String phone1;
  final String? phone2;
  final String address;
  final String wayHome;
  final String caseHistory;
  final String centerId;
  final String createdBy;
  final Neighbour? neighbour;
  final List<HouseholdMember> household;

  Patient({
    required this.id,
    required this.caseNo,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone1,
    this.phone2,
    required this.address,
    required this.wayHome,
    required this.caseHistory,
    required this.centerId,
    required this.createdBy,
    this.neighbour,
    this.household = const [],
  });

  factory Patient.fromMap(String id, Map<String, dynamic> map) {
    return Patient(
      id: id,
      caseNo: map['caseNo'] ?? '',
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      gender: map['gender'] ?? '',
      phone1: map['phone1'] ?? '',
      phone2: map['phone2'],
      address: map['address'] ?? '',
      wayHome: map['wayHome'] ?? '',
      caseHistory: map['caseHistory'] ?? '',
      centerId: map['centerId'] ?? '',
      createdBy: map['createdBy'] ?? '',
      neighbour: map['neighbour'] != null
          ? Neighbour.fromMap(Map<String, dynamic>.from(map['neighbour']))
          : null,
      household: map['household'] != null
          ? List<Map<String, dynamic>>.from(map['household'])
              .map((m) => HouseholdMember.fromMap(m))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'caseNo': caseNo,
      'name': name,
      'age': age,
      'gender': gender,
      'phone1': phone1,
      'phone2': phone2,
      'address': address,
      'wayHome': wayHome,
      'caseHistory': caseHistory,
      'centerId': centerId,
      'createdBy': createdBy,
      'neighbour': neighbour?.toMap(),
      'household': household.map((h) => h.toMap()).toList(),
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
