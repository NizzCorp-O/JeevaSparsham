// infrastructure/firebase/member_firebase_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_pratice/features/members/domain/entities/member.dart';
import 'package:hello_pratice/features/members/domain/repositories/member_repository.dart';

class MemberFirebaseRepository implements MemberRepository {
  final FirebaseFirestore firestore;

  MemberFirebaseRepository({required this.firestore});

  /// Fetch members as Future. Optional role filter.
  Future<List<Member>> getMembers({String? role}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot;

    if (role == null || role == 'All') {
      // Fetch all members
      snapshot = await firestore.collection('members').get();
    } else {
      // Fetch members filtered by role
      snapshot = await firestore
          .collection('members')
          .where('role', isEqualTo: role)
          .get();
    }

    // Map Firestore documents to Member objects
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Member(
        id: doc.id,
        name: data['name'] ?? '',
        location: data['location'],
        phone: data['phone'] ?? '',
        role: data['role'] ?? '',
        avatarUrl: data['avatarUrl'] ?? '',
        email: data['email'] ?? '',
        address: data['address'] ?? '',
        skill: List<String>.from(data['skill'] ?? []),
        patientsServed: (data['patientsServed'] ?? 0) as int,
        satisfactionRate: (data['satisfactionRate'] ?? 0) as int,
        assignedPatients: (data['assignedPatients'] ?? 0) as int,
        notes: data['notes'] ?? '',
      );
    }).toList();
  }

  /// Get all members
  @override
  Future<List<Member>> getAllMembers() => getMembers();

  /// Get members filtered by role
  @override
  Future<List<Member>> getMembersByRole(String role) => getMembers(role: role);

  /// Get single member by ID
  Future<Member?> getMemberById(String id) async {
    final doc =
        await firestore.collection('members').doc(id).get();

    if (!doc.exists) return null;

    final data = doc.data()!;
    return Member(
      id: doc.id,
      name: data['name'] ?? '',
      location: data['location'],
      role: data['role'] ?? '',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      address: data['address'] ?? '',
      avatarUrl: data['avatarUrl'] ?? '',
      skill: List<String>.from(data['skill'] ?? []),
      patientsServed: (data['patientsServed'] ?? 0) as int,
      satisfactionRate: (data['satisfactionRate'] ?? 0) as int,
      assignedPatients: (data['assignedPatients'] ?? 0) as int,
      notes: data['notes'] ?? '',
    );
  }

 @override
  Future<void> addSkill(String memberId, String skill) async {
    await firestore.collection('members').doc(memberId).update({
      'skill': FieldValue.arrayUnion([skill]),
    });
  }

  @override
  Future<void> removeSkill(String memberId, String skill) async {
    await firestore.collection('members').doc(memberId).update({
      'skill': FieldValue.arrayRemove([skill]),
    });
  }

  @override
Future<void> updateNotes(String memberId, String notes) async {
    try {
      await firestore.collection('members').doc(memberId).update({'notes': notes});
    } catch (e) {
      throw Exception('Failed to update notes: $e');
    }
  }


}


// // infrastructure/firebase/member_firebase_repository.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:palliative_sample/features/members/domain/entities/member.dart';
// import 'package:palliative_sample/features/members/domain/repositories/member_repository.dart';


// class MemberFirebaseRepository implements MemberRepository {
//   final FirebaseFirestore firestore;

//   MemberFirebaseRepository({required this.firestore});
  

//   @override
//   Future<List<Member>> getAllMembers() async {
//     final snapshot = await firestore.collection('members').get();
//     return snapshot.docs.map((doc) {
//       final data = doc.data();
//       return Member(
//         id: doc.id,
//         name: data['name'] ?? '',
//         phone: data['phone'] ?? '',
//         role: data['role'] ?? '',
//         avatarUrl: data['avatarUrl'] ?? '',
//       );
//     }).toList();
//   }

//   @override
//   Future<List<Member>> getMembersByRole(String role) async {
//     if (role == 'All') return getAllMembers();
//     final snapshot =
//         await firestore.collection('members').where('role', isEqualTo: role).get();
//     return snapshot.docs.map((doc) {
//       final data = doc.data();
//       return Member(
//         id: doc.id,
//         name: data['name'] ?? '',
//         phone: data['phone'] ?? '',
//         role: data['role'] ?? '',
//         avatarUrl: data['avatarUrl'] ?? '',
//       );
//     }).toList();
//   }
// }
