import 'package:hello_pratice/features/auth/domain/repositories/i_auth_repository.dart';

class LogoutUsecase {
  final IAuthRepository repository;

  LogoutUsecase(this.repository);

  Future<void> call() async {
    try {
      await repository.logout();
    } catch (e) {
      rethrow;
    }
  }
}
