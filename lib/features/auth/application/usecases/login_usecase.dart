import 'package:hello_pratice/features/auth/domain/repositories/i_auth_repository.dart';

class LoginUsecase {
  final IAuthRepository repository;
  LoginUsecase(this.repository);
  Future<String?> call({required String email, required String password}) async {
    try {
      String? userId = await repository.login(email: email, password: password);
      return userId;
    } catch (e) {
      rethrow;
    }
  }
}
