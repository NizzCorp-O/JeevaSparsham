import 'package:hello_pratice/features/create_member/domain/entities/members.dart';


abstract class MemberRepository {
  Future<void> createMember(Member member);
  Future<void> updateMember(Member member);
  Future<void> deleteMember(String id);
}

abstract class LocationRepository {
  Future<String?> getAddressFromCoordinates({
    required double lat,
    required double lon,
  });
}