import 'package:hello_pratice/features/profile/domain/entities/user_profile.dart';
import 'package:hello_pratice/features/profile/domain/repositories/i_profile_repository.dart';

class GetUserProfileUsecase {
  final IProfileRepository repository;

  GetUserProfileUsecase(this.repository);
  Future<UserProfile> call(String userId) {
    return repository.getUserProfile(userId);
  }
}
