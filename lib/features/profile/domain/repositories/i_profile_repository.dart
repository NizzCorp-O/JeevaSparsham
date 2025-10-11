import 'package:hello_pratice/features/profile/domain/entities/user_profile.dart';

abstract class IProfileRepository {
  Future<UserProfile> getUserProfile(String userId);
}
