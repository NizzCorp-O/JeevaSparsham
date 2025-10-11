// domain/entities/member.dart
class Member {
  final String id;
  final String location;
  final String name;
  final String phone;
  final String role;
  final String avatarUrl;
  final String email;
  final String address;
  final List<String> skill;
  final int patientsServed;
  final int satisfactionRate;
  final int assignedPatients;
  final String notes;

  Member({
    required this.id,
    required this.location,
    required this.name,
    required this.phone,
    required this.role,
    required this.avatarUrl,
    required this.email,
    required this.address,
    required this.skill,
    required this.patientsServed,
    required this.satisfactionRate,
    required this.assignedPatients,
    required this.notes,
  });
 
}
