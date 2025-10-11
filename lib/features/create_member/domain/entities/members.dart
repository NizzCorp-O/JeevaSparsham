class Member {
  final String id;
  final String name;
  final String role; // Admin, Doctor, Nurse, Volunteer, Patient
  final String mobile;
  final String? email;
  final String? location;
  final List<String> skills;
  final String? profileUrl;

  Member({
    required this.id,
    required this.name,
    required this.role,
    required this.mobile,
    this.email,
    this.location,
    required this.skills,
    this.profileUrl,
  });
}