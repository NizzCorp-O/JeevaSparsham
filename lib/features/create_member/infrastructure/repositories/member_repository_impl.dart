import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_pratice/features/create_member/domain/entities/members.dart';
import 'package:hello_pratice/features/create_member/domain/entities/repositories/member_repository.dart';

class MemberRepositoryImpl implements MemberRepository {
  final FirebaseFirestore firestore;
  MemberRepositoryImpl(this.firestore);

  @override
  Future<void> createMember(Member member) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("No authenticated user found.");
    }
    await firestore.collection("members").add({
      "uid": user.uid,
      "name": member.name,
      "role": member.role,
      "phone": member.mobile,
      "email": member.email,
      "location": member.location,
      "skill": member.skills,
      "avatarUrl": member.profileUrl ?? "",
      "assignedPatients": null,
      "notes": "",
      "patientsServed": null,
      "satisfactionRate": null,
    });
  }

  @override
  Future<void> updateMember(Member member) async {
    await firestore.collection("members").doc(member.id).update({
      "name": member.name,
      "role": member.role,
      "mobile": member.mobile,
      "email": member.email,
      "location": member.location,
      "skills": member.skills,
    });
  }

  @override
  Future<void> deleteMember(String id) async {
    await firestore.collection("members").doc(id).delete();
  }

  Future<List<Member>> getAllMembers() async {
    final snapshot = await firestore.collection("members").get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Member(
        id: doc.id,
        name: data["name"],
        role: data["role"],
        mobile: data["mobile"],
        email: data["email"],
        location: data["location"],
        skills: List<String>.from(data["skills"] ?? []),
        profileUrl: data["avatarUrl"] ?? '',
      );
    }).toList();
  }
}
