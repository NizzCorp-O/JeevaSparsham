import 'package:hello_pratice/features/create_member/domain/entities/members.dart';
import 'package:hello_pratice/features/create_member/domain/entities/repositories/member_repository.dart';

class CreateMember {
  final MemberRepository repository;
  CreateMember(this.repository);

  Future<void> call(Member member) async {
    return await repository.createMember(member);
  }
}