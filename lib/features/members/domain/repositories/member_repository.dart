// domain/repositories/member_repository.dart
import '../entities/member.dart';

abstract class MemberRepository {
  Future<List<Member>> getAllMembers();
  Future<List<Member>> getMembersByRole(String role);
  Future<Member?> getMemberById(String id);

   
  Future<void> addSkill(String memberId, String skill);
  Future<void> removeSkill(String memberId, String skill);
  Future<void> updateNotes(String memberId, String notes);
}
