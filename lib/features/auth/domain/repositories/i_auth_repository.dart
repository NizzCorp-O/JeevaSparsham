abstract class IAuthRepository {
  Future<String?> login({required String email, required String password});
  Future<void> logout();
  Future<String> getUserRole(String uid);
}
