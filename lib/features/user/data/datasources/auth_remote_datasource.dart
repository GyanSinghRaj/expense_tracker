abstract class AuthRemoteDataSource {
  Future<String> login(String email, String password);
  Future<void> logout();
}
