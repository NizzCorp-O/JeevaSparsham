import 'package:hello_pratice/features/auth/domain/repositories/i_auth_repository.dart';

class CheckUserRoleUsecase {
  final IAuthRepository repository;
  CheckUserRoleUsecase(this.repository);

  Future<String> call(String uid) async {
    try {
      final String userRole = await repository.getUserRole(uid);
      return userRole;
    } catch (e) {
      rethrow;
    }
  }
}
